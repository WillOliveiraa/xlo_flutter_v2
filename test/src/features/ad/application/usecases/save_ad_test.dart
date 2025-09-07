import 'package:flutter_test/flutter_test.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/repositories/ad_repository_database.dart';

import '../../../../mocks/ad_mock.dart';

void main() {
  final adRespository = AdRepositoryDatabase();
  final saveAd = SaveAd(adRespository);

  test('should save an ad', () async {
    final ad = Ad.fromMap(adsMocks.first);
    expect(await saveAd.call(ad), isA<void>());
  });
}
