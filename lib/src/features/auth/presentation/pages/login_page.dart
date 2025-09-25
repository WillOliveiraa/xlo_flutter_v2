import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/login_input.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginViewmodel loginView;
  late final LoginInputValidator validator;
  late final LoginInput input;
  final httpClient = ParseServerAdapter();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginView = context.read<LoginViewmodel>();
    validator = LoginInputValidator();
    input = LoginInput.empty();
  }

  @override
  void didChangeDependencies() {
    loginView.loginCommand.errors.listen((commandError, _) {
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
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: loginView.loginCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: input.setEmail,
                    validator: validator.byField(input, 'email'),
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                valueListenable: loginView.loginCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    onChanged: input.setPassword,
                    validator: validator.byField(input, 'password'),
                    obscureText: true,
                    enabled: !isExecuting,
                  );
                },
              ),
              const SizedBox(height: 32.0),
              ValueListenableBuilder(
                valueListenable: loginView.loginCommand.isExecuting,
                builder: (_, isExecuting, _) {
                  return OutlinedButton(
                    onPressed:
                        isExecuting
                            ? null
                            : () {
                              if (formKey.currentState!.validate()) {
                                loginView.loginCommand.execute(input);
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
                            : const Text('Login'),
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
