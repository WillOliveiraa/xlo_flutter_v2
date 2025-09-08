import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';

import 'http_client.dart';

class ParseServerAdapter implements HttpClient {
  @override
  Future<Either<Failure, List<dynamic>>> get(String url) async {
    final parseObject = ParseObject(url);
    final response = await parseObject.getAll();
    if (response.success && response.results != null) {
      final convertedList =
          response.results!.map((e) {
            final json = e.toJson() as Map<String, dynamic>;
            json['id'] = e.objectId;
            return json;
          }).toList();
      return Right(convertedList);
    } else {
      debugPrint(response.error?.message);
      return Left(ApiError(response.error?.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, Object>> post(
    String url,
    Map<String, dynamic> data,
  ) async {
    final parseObject = ParseObject(url);
    for (final entry in data.entries) {
      parseObject.set(entry.key, entry.value);
    }
    final response = await parseObject.save();
    if (response.success) {
      return Right(response.result);
    } else {
      debugPrint(response.error?.message);
      return Left(ApiError(response.error?.message ?? 'Unknown error'));
    }
  }
}
