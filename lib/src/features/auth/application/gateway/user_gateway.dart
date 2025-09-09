import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

abstract class UserGateway {
  Future<Either<Failure, Unit>> signUp(SignUpEntity signUp);
  Future<Either<Failure, User?>> getUserById(String id);
}
