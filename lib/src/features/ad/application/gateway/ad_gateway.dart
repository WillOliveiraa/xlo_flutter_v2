import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/http/custom_query_builder.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/types/ad_query.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

abstract class AdGateway {
  Future<Either<Failure, Unit>> save(Ad ad);
  Future<Either<Failure, List<AdQuery>>> getAll(CustomQueryBuilder? filters);
  Future<Either<Failure, AdQuery?>> getById(
    String id,
    CustomQueryBuilder? filters,
  );
}
