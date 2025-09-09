import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/custom_argument_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/gateway/user_gateway.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

class Login {
  final UserGateway _userGateway;

  Login(this._userGateway);

  Future<Either<Failure, User>> call(LoginInput input) async {
    final validation = input.validate(input);
    if (validation.exceptions.isNotEmpty) {
      return Left(CustomArgumentError(exceptions: validation.exceptions));
    }
    return await _userGateway.login(input);
  }
}
