import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_category.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/category_gateway_http.dart';

import '../../../../mocks/mock_parse_server_adapter.dart';

void main() {
  final httpClient = MockParseServerAdapter();
  final categoryGateway = CategoryGatewayHttp(httpClient);
  final saveCategory = SaveCategory(categoryGateway);
  final category = Category(id: '1', description: 'Eletrônicos');

  test('should save a new category', () async {
    // arrange
    when(
      () => httpClient.post(any(), any()),
    ).thenAnswer((_) async => const Right(unit));

    // act
    final result = (await saveCategory(category)).fold((l) => null, (r) => r);

    //assert
    expect(result, unit);
  });

  test('should return a ApiError', () async {
    when(
      () => httpClient.post(keyCategoryTable, category.toMap()),
    ).thenAnswer((_) async => Left(ApiError('Any error')));

    final result = (await saveCategory(category)).fold(id, id);

    expect(result, isA<ApiError>());
    expect((result as ApiError).message, 'Any error');
  });
}
