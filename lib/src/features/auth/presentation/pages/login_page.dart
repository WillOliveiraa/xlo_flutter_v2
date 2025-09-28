import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/routers/routers.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/login_input.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginViewmodel loginViewmodel;
  late final LoginInputValidator validator;
  late final LoginInput input;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginViewmodel = context.read<LoginViewmodel>();
    validator = LoginInputValidator();
    input = LoginInput.empty();
  }

  @override
  void didChangeDependencies() {
    loginViewmodel.loginCommand.errors.listen((commandError, _) {
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
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 26.0),
                  child: Text(
                    'Bem-vindo de volta, faça login para continuar sua jornada',
                    style: TextTheme.of(context).bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: loginViewmodel.loginCommand.isExecuting,
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
                  valueListenable: loginViewmodel.loginCommand.isExecuting,
                  builder: (_, isExecuting, _) {
                    return ValueListenableBuilder(
                      valueListenable: loginViewmodel.passwordVisibility,
                      builder: (_, passwordVisibility, _) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap:
                                  () => loginViewmodel.passwordVisibility
                                      .execute(!passwordVisibility),
                              child: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.black40,
                                size: 24,
                              ),
                            ),
                          ),
                          onChanged: input.setPassword,
                          validator: validator.byField(input, 'password'),
                          obscureText: !loginViewmodel.passwordVisibility.value,
                          enabled: !isExecuting,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextTheme.of(context).bodyMedium,
                    ),
                    onTap:
                        () => Navigator.of(context).pushNamed(Routers.signUp),
                  ),
                ),
                const SizedBox(height: 32.0),
                ValueListenableBuilder(
                  valueListenable: loginViewmodel.loginCommand.isExecuting,
                  builder: (_, isExecuting, _) {
                    return OutlinedButton(
                      onPressed:
                          isExecuting
                              ? null
                              : () {
                                if (formKey.currentState!.validate()) {
                                  loginViewmodel.loginCommand.execute(input);
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
      ),
    );
  }
}
