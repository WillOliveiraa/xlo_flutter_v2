import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/get_all_ads.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/types/ad_query.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';

import '../../../../mocks/ad_mock.dart';

class MockParseServerAdapter extends Mock implements ParseServerAdapter {}

void main() {
  final httpClient = MockParseServerAdapter();
  final adGateway = AdGatewayHttp(httpClient);
  final getAllAds = GetAllAds(adGateway);

  test('should get all ads', () async {
    // arrange
    when(
      () => httpClient.get(
        'query',
        // filters: CustomQueryBuilder(
        //   tableName: keyAdTable,
        //   includes: ['user', 'category'],
        // ),
      ),
    ).thenAnswer((_) async => Right(adsMocks));

    // act
    final result = (await getAllAds()).fold((l) => null, (r) => r);

    //assert
    expect(result, isA<List<AdQuery>>());
    expect(result?.length, 2);
  });

  test('should return a ApiError', () async {
    when(
      () => httpClient.get('query'),
    ).thenAnswer((_) async => Left(ApiError('Any error')));

    final result = (await getAllAds()).fold(id, id);

    expect(result, isA<ApiError>());
    expect((result as ApiError).message, 'Any error');
  });
}
