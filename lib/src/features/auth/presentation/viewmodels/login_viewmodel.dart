import 'package:command_it/command_it.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/login_input.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

class LoginViewmodel {
  final Login _loginUsecase;
  late final Command<LoginInput, User?> loginCommand;

  LoginViewmodel(this._loginUsecase) {
    loginCommand = Command.createAsync<LoginInput, User?>(
      _login,
      initialValue: null,
    );
  }

  Future<User?> _login(LoginInput input) async {
    final result = await _loginUsecase(input);
    await Future.delayed(const Duration(seconds: 2));
    return result.fold((l) => throw l, (data) => data);
  }
}
