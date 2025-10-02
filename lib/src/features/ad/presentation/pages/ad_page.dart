import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/core/widgets/ds_select.dart';
import 'package:xlo_flutter_v2/src/core/widgets/skeleton/ds_skeleton.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/presentation/viewmodels/ad_viewmodel.dart';

class AdPage extends StatefulWidget {
  const AdPage({super.key});

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  late final AdViewmodel adViewmodel;
  late final AdValidator validator;
  late final Ad input;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    adViewmodel = context.read<AdViewmodel>();
    validator = AdValidator();
    input = Ad.empty();
  }

  @override
  void didChangeDependencies() {
    adViewmodel.saveAdCommand.errors.listen((commandError, _) {
      if (commandError != null && commandError.error is ApiError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              (commandError.error as ApiError).message ?? 'An error occurred',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Anúncio')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: Text(
                  'Preencha os dados do anúncio',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return TextFormField(
                    decoration: const InputDecoration(labelText: 'Título'),
                    onChanged: input.setTitle,
                    validator: validator.byField(input, 'title'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return TextFormField(
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    onChanged: input.setDescription,
                    validator: validator.byField(input, 'description'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return TextFormField(
                    decoration: const InputDecoration(labelText: 'Preço'),
                    keyboardType: TextInputType.number,
                    onChanged:
                        (value) => input.setPrice(double.tryParse(value) ?? 0),
                    validator: validator.byField(input, 'price'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: adViewmodel.getAllCategoriesCommand.results,
                builder: (_, result, __) {
                  if (result.isExecuting) {
                    return DSSkeleton(
                      child: DSSkeletonContainer(
                        height: 54,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  }
                  if (result.hasData) {
                    return DSSelect(
                      label: 'Categoria',
                      children:
                          result.data!.map((item) => item.description).toList(),
                      onChanged: (value) {
                        final item = result.data!.firstWhere(
                          (el) => el.description == value,
                        );
                        input.setCategory(item);
                      },
                      validator: validator.byField(input, 'category'),
                      enabled: !result.isExecuting,
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              const SizedBox(height: 32.0),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return OutlinedButton(
                    onPressed:
                        isExecuting
                            ? null
                            : () {
                              debugPrint(
                                validator.getExceptions(input).toString(),
                              );
                              if (formKey.currentState!.validate()) {
                                adViewmodel.saveAdCommand.execute(input);
                              }
                            },
                    child:
                        isExecuting
                            ? SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: CircularProgressIndicator(
                                color: AppColors.info,
                              ),
                            )
                            : const Text('Cadastrar'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
