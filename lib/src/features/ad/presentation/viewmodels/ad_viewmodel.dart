import 'package:command_it/command_it.dart';
import 'package:dartz/dartz.dart';
import 'package:xlo_flutter_v2/src/core/http/custom_query_builder.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/get_all_categories.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

class AdViewmodel {
  final SaveAd _saveAdUsecase;
  final GetAllCategories _getAllCategories;
  late final Command<Ad, Unit?> saveAdCommand;
  late final Command<void, List<Category>> getAllCategoriesCommand;

  AdViewmodel(this._saveAdUsecase, this._getAllCategories) {
    saveAdCommand = Command.createAsync(_saveAd, initialValue: null);
    getAllCategoriesCommand = Command.createAsync(
      _getCategories,
      initialValue: [],
    );
    getAllCategoriesCommand.execute();
  }

  Future<Unit?> _saveAd(Ad input) async {
    final result = await _saveAdUsecase(input);
    await Future.delayed(const Duration(seconds: 2));
    return result.fold((l) => throw l, (data) => data);
  }

  Future<List<Category>> _getCategories(_) async {
    final result = await _getAllCategories(
      filters: CustomQueryBuilder(tableName: keyCategoryTable),
    );
    await Future.delayed(const Duration(seconds: 2));
    return result.fold((l) => throw l, (data) => data);
  }
}
