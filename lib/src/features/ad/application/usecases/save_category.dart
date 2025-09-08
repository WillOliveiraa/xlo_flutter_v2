import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/gateway/category_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

class SaveCategory {
  final CategoryGateway categoryGateway;

  SaveCategory(this.categoryGateway);

  Future<Either<Failure, Unit>> call(Category category) async {
    return await categoryGateway.save(category);
  }
}
