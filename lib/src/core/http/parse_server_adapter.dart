import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';

import 'http_client.dart';

class ParseServerAdapter implements HttpClient {
  @override
  Future<Either<Failure, List<dynamic>>> get(String url) async {
    if (url == keyUserTable) {
      return await currentUser();
    }
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
    switch (url) {
      case keySignUp:
        return await signUp(data);
      case keyLogin:
        return await login(data);
    }
    final parseObject = ParseObject(url);
    for (final entry in data.entries) {
      if (entry.value is Map) {
        final itemTable = tableKeys.firstWhere((el) => el['id'] == entry.key);
        if (itemTable['id'] != null && itemTable['id'] == 'user') {
          final parseUser = await ParseUser.currentUser() as ParseUser;
          parseObject.set(entry.key, parseUser);
          continue;
        }
        parseObject.set(
          itemTable['id']!,
          ParseObject(itemTable['label']!)..set('objectId', entry.value['id']),
        );
        continue;
      }
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

  Future<Either<Failure, Object>> signUp(Map<String, dynamic> data) async {
    final user = ParseUser(data['email'], data['password'], data['email']);
    user.set('name', data['name']);
    user.set('phone', data['phone']);
    user.set('type', data['type']);
    final response = await user.signUp();
    if (response.success) {
      return Right(response.result);
    } else {
      debugPrint(response.error?.message);
      return Left(ApiError(response.error?.message ?? 'Unknown error'));
    }
  }

  Future<Either<Failure, Object>> login(Map<String, dynamic> data) async {
    final parseUser = ParseUser(data['email'], data['password'], null);
    final response = await parseUser.login();
    if (response.success) {
      final convertedList =
          response.results!.map((e) {
            final json = e.toJson() as Map<String, dynamic>;
            json['id'] = e.objectId;
            return json;
          }).toList();
      return Right(convertedList.first);
    } else {
      debugPrint(response.error?.message);
      return Left(ApiError(response.error?.message ?? 'Unknown error'));
    }
  }

  Future<Either<Failure, List<dynamic>>> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    final response = await ParseUser.getCurrentUserFromServer(
      parseUser.sessionToken!,
    );
    if (response != null && response.success) {
      final convertedList =
          response.results!.map((e) {
            final json = e.toJson() as Map<String, dynamic>;
            json['id'] = e.objectId;
            return json;
          }).toList();
      return Right(convertedList);
    }
    return Left(ApiError(response?.error?.message ?? 'Unknown error'));
  }
}
