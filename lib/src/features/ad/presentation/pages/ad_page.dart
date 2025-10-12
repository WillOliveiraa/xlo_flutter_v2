import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/spacings/spacing.dart';
import 'package:xlo_flutter_v2/src/design_system/atoms/text/ds_text.dart';
import 'package:xlo_flutter_v2/src/design_system/molecules/button/ds_button.dart';
import 'package:xlo_flutter_v2/src/design_system/molecules/select/ds_select.dart';
import 'package:xlo_flutter_v2/src/design_system/molecules/text_field/ds_text_field.dart';
import 'package:xlo_flutter_v2/src/design_system/organisms/skeleton/ds_skeleton.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/presentation/viewmodels/ad_viewmodel.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/auth_viewmodel.dart';

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
            content: DSText(
              (commandError.error as ApiError).message ?? 'An error occurred',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
    adViewmodel.saveAdCommand.results.listen((command, _) {
      if (command.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: DSText('Ad saved succefully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
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
              DSText(
                'Preencha os dados do anúncio',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                margin: const EdgeInsets.only(bottom: Spacing.x4),
              ),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return DSTextField(
                    labelText: 'Título',
                    onChanged: input.setTitle,
                    validator: validator.byField(input, 'title'),
                    enabled: !isExecuting,
                    margin: const EdgeInsets.only(top: Spacing.x2),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return DSTextField(
                    labelText: 'Descrição',
                    onChanged: input.setDescription,
                    validator: validator.byField(input, 'description'),
                    enabled: !isExecuting,
                    margin: const EdgeInsets.only(top: Spacing.x2),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return DSTextField(
                    labelText: 'Preço',
                    keyboardType: TextInputType.number,
                    onChanged:
                        (value) => input.setPrice(double.tryParse(value) ?? 0),
                    validator: validator.byField(input, 'price'),
                    enabled: !isExecuting,
                    margin: const EdgeInsets.only(top: Spacing.x2),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: adViewmodel.getAllCategoriesCommand.results,
                builder: (_, result, __) {
                  if (result.isExecuting) {
                    return DSSkeleton(
                      child: DSSkeletonContainer(
                        margin: const EdgeInsets.only(top: Spacing.x2),
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
                      margin: const EdgeInsets.only(top: Spacing.x2),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              const SizedBox(height: 32.0),
              ValueListenableBuilder(
                valueListenable: adViewmodel.saveAdCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return DSButton(
                    label: 'Cadastrar',
                    isLoading: isExecuting,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        input.setOwner(context.read<AuthViewModel>().user!);
                        adViewmodel.saveAdCommand.execute(input);
                      }
                    },
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
