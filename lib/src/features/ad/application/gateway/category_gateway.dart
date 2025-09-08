import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/errors/failure.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

abstract class CategoryGateway {
  Future<Either<Failure, Unit>> save(Category category);
  Future<Either<Failure, List<Category>>> getAll();
}
