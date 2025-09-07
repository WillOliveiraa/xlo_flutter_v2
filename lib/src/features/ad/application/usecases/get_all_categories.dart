import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/ad/gateways/category_gateway.dart';

class GetAllCategories {
  final CategoryGateway categoryGateway;

  GetAllCategories(this.categoryGateway);

  Future<Either<Failure, List<Category>>> call() async {
    return categoryGateway.getAll();
  }
}
