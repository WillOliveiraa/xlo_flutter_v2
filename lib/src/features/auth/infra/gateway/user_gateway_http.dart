import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/http/http_client.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/gateway/user_gateway.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

class UserGatewayHttp implements UserGateway {
  final HttpClient _httpClient;

  UserGatewayHttp(this._httpClient);

  @override
  Future<Either<Failure, Unit>> signUp(SignUpEntity user) async {
    final response = await _httpClient.post(keySignUp, user.toMap());
    return response.fold((failure) => Left(failure), (data) => Right(unit));
  }

  @override
  Future<Either<Failure, User?>> getUserById(String id) async {
    final response = await _httpClient.get(keyUserTable);
    return response.fold((failure) => Left(failure), (data) {
      final user =
          data.map((e) => User.fromMap(e as Map<String, dynamic>)).toList();
      return Right(user.isNotEmpty ? user.first : null);
    });
  }

  @override
  Future<Either<Failure, User>> login(LoginInput input) async {
    final response = await _httpClient.post(keyLogin, input.toMap());
    return response.fold((failure) => Left(failure), (data) {
      return Right(User.fromMap(data as Map<String, dynamic>));
    });
  }
}
