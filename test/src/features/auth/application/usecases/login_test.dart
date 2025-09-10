import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/custom_argument_error.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/enum/user_type.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';
import 'package:xlo_flutter_v2/src/features/auth/infra/gateway/user_gateway_http.dart';

import '../../../../mocks/mock_parse_server_adapter.dart';
import '../../../../mocks/user_mock.dart';

void main() {
  final httpClient = MockParseServerAdapter();
  final userGateway = UserGatewayHttp(httpClient);
  final login = Login(userGateway);
  final input = LoginInput(
    usersMock.first['email'],
    usersMock.first['password'],
  );

  test('should log in user', () async {
    when(
      () => httpClient.post(any(), any()),
    ).thenAnswer((_) async => Right(usersMock.first));

    final result = (await login(input)).fold((l) => null, (r) => r);

    expect(result, isA<User>());
    expect(result?.id, '1');
    expect(result?.name, 'John Doe');
    expect(result?.email, 'john.doe@gmail.com');
    expect(result?.phone, '123-456-7890');
    expect(result?.type, UserType.particular);
    expect(result?.image, isNull);
  });

  test('should return a CustomArgumentError', () async {
    final result = (await login(LoginInput('', ''))).fold(id, id);

    expect(result, isA<CustomArgumentError>());
    expect((result as CustomArgumentError).exceptions.length, 4);
  });

  test('should return a ApiError', () async {
    when(
      () => httpClient.post(keyLogin, any()),
    ).thenAnswer((_) async => Left(ApiError('Any error')));

    final result = (await login(input)).fold(id, id);

    expect(result, isA<ApiError>());
    expect((result as ApiError).message, 'Any error');
  });
}
