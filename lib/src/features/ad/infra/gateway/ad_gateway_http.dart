import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/http/custom_query_builder.dart';
import 'package:xlo_flutter_v2/src/core/http/http_client.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/ad_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/types/ad_query.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';

class AdGatewayHttp implements AdGateway {
  final HttpClient httpClient;

  AdGatewayHttp(this.httpClient);

  @override
  Future<Either<Failure, Unit>> save(Ad ad) async {
    final response = await httpClient.post(keyAdTable, ad.toMap());
    return response.fold((failure) => Left(failure), (data) => Right(unit));
  }

  @override
  Future<Either<Failure, List<AdQuery>>> getAll(
    CustomQueryBuilder? filters,
  ) async {
    final response = await httpClient.get('query', filters: filters);
    return response.fold((failure) => Left(failure), (data) {
      final ads =
          data.map((e) => AdQuery.fromMap(e as Map<String, dynamic>)).toList();
      return Right(ads);
    });
  }

  @override
  Future<Either<Failure, AdQuery?>> getById(
    String id,
    CustomQueryBuilder? filters,
  ) async {
    final response = await httpClient.get('query/$id', filters: filters);
    return response.fold((failure) => Left(failure), (data) {
      final ads =
          data.map((e) => AdQuery.fromMap(e as Map<String, dynamic>)).toList();
      return Right(ads.isEmpty ? null : ads.first);
    });
  }
}
