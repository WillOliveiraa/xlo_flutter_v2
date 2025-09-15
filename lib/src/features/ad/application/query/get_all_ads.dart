import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/http/custom_query_builder.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/ad_gateway.dart';

import './types/ad_query.dart';

class GetAllAds {
  final AdGateway adGateway;

  GetAllAds(this.adGateway);

  Future<Either<Failure, List<AdQuery>>> call({
    CustomQueryBuilder? filters,
  }) async {
    return adGateway.getAll(filters);
  }
}
