import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/get_user_by_id.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';
import 'package:xlo_flutter_v2/src/features/auth/infra/gateway/user_gateway_http.dart';

import '../../../../mocks/user_mock.dart';

class MockParseServerAdapter extends Mock implements ParseServerAdapter {}

void main() {
  final httpClient = MockParseServerAdapter();
  final userGateway = UserGatewayHttp(httpClient);
  final getUserById = GetUserById(userGateway);
  final input = '1';

  test('should get an user by id', () async {
    // arrange
    when(
      () => httpClient.get(any()),
    ).thenAnswer((_) async => Right([usersMock.first]));

    // act
    final result = (await getUserById(input)).fold((l) => null, (r) => r);

    //assert
    expect(result, isA<User>());
  });

  test('should return a ApiError', () async {
    when(
      () => httpClient.get(any()),
    ).thenAnswer((_) async => Left(ApiError('Any error')));

    final result = (await getUserById(input)).fold(id, id);

    expect(result, isA<ApiError>());
    expect((result as ApiError).message, 'Any error');
  });
}
