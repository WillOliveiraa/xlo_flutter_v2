import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/gateway/user_gateway.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

class GetUserById {
  final UserGateway _userGateway;

  GetUserById(this._userGateway);

  Future<Either<Failure, User?>> call(String id) async {
    return _userGateway.getUserById(id);
  }
}
