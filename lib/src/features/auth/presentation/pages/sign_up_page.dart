import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/design_system/molecules/button/ds_button.dart';
import 'package:xlo_flutter_v2/src/design_system/molecules/text_field/ds_text_field.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/sign_up_viewmodel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpViewmodel signUpViewmodel;
  late final SignUpInputValidator validator;
  late final SignUpEntity input;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    signUpViewmodel = context.read<SignUpViewmodel>();
    validator = SignUpInputValidator();
    input = SignUpEntity.empty();
  }

  @override
  void didChangeDependencies() {
    signUpViewmodel.signUpCommand.errors.listen((commandError, _) {
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
      appBar: AppBar(title: const Text('Sign Up')),
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
                  'Crie sua conta para começar sua jornada',
                  style: TextTheme.of(context).bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: signUpViewmodel.signUpCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return DSTextField(
                    labelText: 'Nome',
                    onChanged: input.setName,
                    validator: validator.byField(input, 'name'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: signUpViewmodel.signUpCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return DSTextField(
                    labelText: 'Email',
                    onChanged: input.setEmail,
                    validator: validator.byField(input, 'email'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: signUpViewmodel.signUpCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return DSTextField(
                    labelText: 'Telefone',
                    onChanged: input.setPhone,
                    validator: validator.byField(input, 'phone'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: signUpViewmodel.signUpCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return ValueListenableBuilder(
                    valueListenable: signUpViewmodel.passwordVisibility,
                    builder: (_, passwordVisibility, _) {
                      return DSTextField(
                        labelText: 'Senha',
                        onChanged: input.setPassword,
                        validator: validator.byField(input, 'password'),
                        obscureText: !signUpViewmodel.passwordVisibility.value,
                        enabled: !isExecuting,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 48.0),
              ValueListenableBuilder(
                valueListenable: signUpViewmodel.signUpCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return DSButton(
                    label: 'Sign Up',
                    isLoading: isExecuting,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        signUpViewmodel.signUpCommand.execute(input);
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
