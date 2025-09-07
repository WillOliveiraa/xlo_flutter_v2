import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/repositories/ad_repository.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

class SaveAd {
  final AdRepository adRepository;

  SaveAd(this.adRepository);

  Future<Either<Failure, void>> call(Ad ad) async {
    return await adRepository.save(ad);
  }
}
