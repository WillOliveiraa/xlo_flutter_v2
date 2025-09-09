import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/infra/gateway/user_gateway_http.dart';

import '../../../../mocks/mock_parse_server_adapter.dart';
import '../../../../mocks/user_mock.dart';

void main() {
  final httpClient = MockParseServerAdapter();
  final userGateway = UserGatewayHttp(httpClient);
  final signUp = SignUpUser(userGateway);
  final user = SignUpEntity.fromMap(usersMock.first);

  test('should save an user', () async {
    when(
      () => httpClient.post(any(), any()),
    ).thenAnswer((_) async => const Right(unit));

    final result = (await signUp(user)).fold((l) => null, (r) => r);

    expect(result, unit);
  });

  test('should return a ApiError', () async {
    when(
      () => httpClient.post(keySignUp, user.toMap()),
    ).thenAnswer((_) async => Left(ApiError('Any error')));

    final result = (await signUp(user)).fold(id, id);

    expect(result, isA<ApiError>());
    expect((result as ApiError).message, 'Any error');
  });
}
