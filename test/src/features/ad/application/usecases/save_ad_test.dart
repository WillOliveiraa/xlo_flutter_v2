import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/custom_argument_error.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

import '../../../../mocks/ad_mock.dart';
import '../../../../mocks/mock_parse_server_adapter.dart';
import '../../../../mocks/user_mock.dart';

void main() {
  final httpClient = MockParseServerAdapter();
  final adGateway = AdGatewayHttp(httpClient);
  final saveAd = SaveAd(adGateway);
  final ad = Ad.fromMap(adsMocks.first);

  test('should save an ad', () async {
    when(
      () => httpClient.post(any(), any()),
    ).thenAnswer((_) async => const Right(unit));

    final result = (await saveAd(ad)).fold((l) => null, (r) => r);

    expect(result, unit);
  });

  test('should return a CustomArgumentError', () async {
    final result = (await saveAd(
      Ad(
        description: '',
        category: Category.fromMap(categoriesMock.first),
        title: '',
        price: 0,
        images: [],
        owner: User.fromMap(usersMock.first),
      ),
    )).fold(id, id);

    expect(result, isA<CustomArgumentError>());
    expect((result as CustomArgumentError).exceptions.length, 4);
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
