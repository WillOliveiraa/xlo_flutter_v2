import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/ad_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/http/http_client.dart';

class AdGatewayHttp implements AdGateway {
  final HttpClient httpClient;

  AdGatewayHttp(this.httpClient);

  @override
  Future<Either<Failure, Unit>> save(Ad ad) async {
    final response = await httpClient.post(keyAdTable, ad.toMap());
    return response.fold((failure) => Left(failure), (data) => Right(unit));
  }

  @override
  Future<Either<Failure, List<Ad>>> getAll() async {
    final response = await httpClient.get(keyAdTable);
    return response.fold((failure) => Left(failure), (data) {
      final ads =
          data.map((e) => Ad.fromMap(e as Map<String, dynamic>)).toList();
      return Right(ads);
    });
  }
}
