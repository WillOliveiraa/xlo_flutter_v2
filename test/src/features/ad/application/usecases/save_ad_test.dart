import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';

import '../../../../mocks/ad_mock.dart';
import '../../../../mocks/mock_parse_server_adapter.dart';

void main() {
  final httpClient = MockParseServerAdapter();
  final adRespository = AdGatewayHttp(httpClient);
  final saveAd = SaveAd(adRespository);
  final ad = Ad.fromMap(adsMocks.first);

  test('should save an ad', () async {
    when(
      () => httpClient.post(any(), any()),
    ).thenAnswer((_) async => const Right(unit));

    final result = (await saveAd(ad)).fold((l) => null, (r) => r);

    expect(result, unit);
  });

  test('should return a ApiError', () async {
    when(
      () => httpClient.post(keyAdTable, ad.toMap()),
    ).thenAnswer((_) async => Left(ApiError('Any error')));

    final result = (await saveAd(ad)).fold(id, id);

    expect(result, isA<ApiError>());
    expect((result as ApiError).message, 'Any error');
  });
}
