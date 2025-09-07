import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/repositories/ad_repository.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

class AdRepositoryDatabase implements AdRepository {
  @override
  Future<Either<Failure, void>> save(Ad ad) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(null);
  }
}
