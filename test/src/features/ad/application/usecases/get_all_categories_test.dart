import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/get_all_categories.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/category_gateway_http.dart';

import '../../../../mocks/ad_mock.dart';

class MockParseServerAdapter extends Mock implements ParseServerAdapter {}

void main() {
  final httpClient = MockParseServerAdapter();
  final categoryGateway = CategoryGatewayHttp(httpClient);
  final getAllCategories = GetAllCategories(categoryGateway);

  test('should get all categories', () async {
    // arrange
    when(
      () => httpClient.get(any()),
    ).thenAnswer((_) async => Right(categoriesMock));

    // act
    final result = (await getAllCategories()).fold((l) => null, (r) => r);

    //assert
    expect(result, isA<List<Category>>());
    expect(result?.length, 4);
  });

  test('should return a ApiError', () async {
    when(
      () => httpClient.get(any()),
    ).thenAnswer((_) async => Left(ApiError('Any error')));

    final result = (await getAllCategories()).fold(id, id);

    expect(result, isA<ApiError>());
    expect((result as ApiError).message, 'Any error');
  });
}
