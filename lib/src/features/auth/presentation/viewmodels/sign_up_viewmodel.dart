import 'package:command_it/command_it.dart';
import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';

class SignUpViewmodel {
  final SignUpUser _signUpUsecase;
  late final Command<SignUpEntity, Unit?> signUpCommand;
  late Command<bool, bool> passwordVisibility;

  SignUpViewmodel(this._signUpUsecase) {
    signUpCommand = Command.createAsync<SignUpEntity, Unit?>(
      _signUp,
      initialValue: null,
    );
    passwordVisibility = Command.createSync(
      setPasswordVisibility,
      initialValue: false,
    );
  }

  Future<Unit?> _signUp(SignUpEntity input) async {
    final result = await _signUpUsecase(input);
    await Future.delayed(const Duration(seconds: 2));
    return result.fold((l) => throw l, (data) => data);
  }

  bool setPasswordVisibility(bool value) => value;
}
