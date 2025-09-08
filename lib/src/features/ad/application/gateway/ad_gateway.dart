import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

abstract class AdGateway {
  Future<Either<Failure, Unit>> save(Ad ad);
  Future<Either<Failure, List<Ad>>> getAll();
}
