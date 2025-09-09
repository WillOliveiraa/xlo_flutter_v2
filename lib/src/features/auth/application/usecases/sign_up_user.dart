import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/custom_argument_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/gateway/user_gateway.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';

class SignUpUser {
  final UserGateway _userGateway;

  SignUpUser(this._userGateway);

  Future<Either<Failure, Unit>> call(SignUpEntity user) async {
    final validation = user.validate(user);
    if (validation.exceptions.isNotEmpty) {
      return Left(CustomArgumentError(exceptions: validation.exceptions));
    }
    return await _userGateway.signUp(user);
  }
}
