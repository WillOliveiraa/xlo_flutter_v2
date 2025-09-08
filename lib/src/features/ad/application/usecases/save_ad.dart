import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/ad_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

class SaveAd {
  final AdGateway adGateway;

  SaveAd(this.adGateway);

  Future<Either<Failure, Unit>> call(Ad ad) async {
    return await adGateway.save(ad);
  }
}
