import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/ad_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

class GetAllAds {
  final AdGateway adGateway;

  GetAllAds(this.adGateway);

  Future<Either<Failure, List<Ad>>> call() async {
    return adGateway.getAll();
  }
}
