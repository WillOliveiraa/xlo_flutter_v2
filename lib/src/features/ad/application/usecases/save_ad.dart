import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/custom_argument_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/ad_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

class SaveAd {
  final AdGateway adGateway;

  SaveAd(this.adGateway);

  Future<Either<Failure, Unit>> call(Ad ad) async {
    final validation = ad.validate(ad);
    if (validation.exceptions.isNotEmpty) {
      return Left(CustomArgumentError(exceptions: validation.exceptions));
    }
    return await adGateway.save(ad);
  }
}
