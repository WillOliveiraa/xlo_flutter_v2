import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';

abstract class HttpClient {
  Future<Either<Failure, List<dynamic>>> get(String url);
  Future<Either<Failure, Object>> post(String url, Map<String, dynamic> data);
}
