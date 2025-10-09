import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

import '../viewmodels/category_viewmodel.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late final CategoryViewModel categoryViewmodel;
  late final CategoryValidator validator;
  late final Category input;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    categoryViewmodel = context.read<CategoryViewModel>();
    validator = CategoryValidator();
    input = Category.empty();
  }

  @override
  void didChangeDependencies() {
    categoryViewmodel.saveCategoryCommand.errors.listen((commandError, _) {
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
    categoryViewmodel.saveCategoryCommand.results.listen((command, _) {
      if (command.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Categoria cadastrada com sucesso!'),
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
      appBar: AppBar(title: const Text('Cadastrar Categoria')),
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
                  'Preencha os dados da categoria',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              ValueListenableBuilder(
                valueListenable:
                    categoryViewmodel.saveCategoryCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return TextFormField(
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    onChanged: input.setDescription,
                    validator: validator.byField(input, 'description'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 32.0),
              ValueListenableBuilder(
                valueListenable:
                    categoryViewmodel.saveCategoryCommand.isExecuting,
                builder: (_, isExecuting, __) {
                  return OutlinedButton(
                    onPressed:
                        isExecuting
                            ? null
                            : () {
                              if (formKey.currentState!.validate()) {
                                categoryViewmodel.saveCategoryCommand.execute(
                                  input,
                                );
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
