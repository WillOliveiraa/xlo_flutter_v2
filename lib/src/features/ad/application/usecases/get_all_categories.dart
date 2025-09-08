import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/category_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

class GetAllCategories {
  final CategoryGateway categoryGateway;

  GetAllCategories(this.categoryGateway);

  Future<Either<Failure, List<Category>>> call() async {
    return categoryGateway.getAll();
  }
}
