import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/core/http/http_client.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/category_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

class CategoryGatewayHttp implements CategoryGateway {
  final HttpClient httpClient;

  CategoryGatewayHttp(this.httpClient);

  @override
  Future<Either<Failure, Unit>> save(Category category) async {
    final response = await httpClient.post(keyCategoryTable, category.toMap());
    return response.fold((failure) => Left(failure), (data) => Right(unit));
  }

  @override
  Future<Either<Failure, List<Category>>> getAll() async {
    final response = await httpClient.get(keyCategoryTable);
    return response.fold((failure) => Left(failure), (data) {
      final categories =
          data.map((e) => Category.fromMap(e as Map<String, dynamic>)).toList();
      return Right(categories);
    });
  }
}
