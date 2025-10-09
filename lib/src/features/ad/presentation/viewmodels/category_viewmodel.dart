import 'package:command_it/command_it.dart';
import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_category.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

class CategoryViewModel {
  final SaveCategory _saveCategoryUsecase;
  late final Command<Category, Unit?> saveCategoryCommand;

  CategoryViewModel(this._saveCategoryUsecase) {
    saveCategoryCommand = Command.createAsync(
      _saveCategory,
      initialValue: null,
    );
  }

  Future<Unit?> _saveCategory(Category input) async {
    final result = await _saveCategoryUsecase(input);
    await Future.delayed(const Duration(seconds: 2));
    return result.fold((l) => throw l, (data) => data);
  }
}
