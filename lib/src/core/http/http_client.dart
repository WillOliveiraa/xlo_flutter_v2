import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/http/custom_query_builder.dart';

abstract class HttpClient {
  Future<Either<Failure, List<dynamic>>> get(
    String url, {
    CustomQueryBuilder? filters,
  });
  Future<Either<Failure, Object>> post(String url, Map<String, dynamic> data);
}
