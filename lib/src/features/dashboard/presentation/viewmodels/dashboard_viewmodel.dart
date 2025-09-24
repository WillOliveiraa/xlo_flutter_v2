import 'package:command_it/command_it.dart';
import 'package:xlo_flutter_v2/src/core/http/custom_query_builder.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/get_all_ads.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/types/ad_query.dart';

class DashboardViewmodel {
  final GetAllAds _getAllAdsUsecase;
  late final Command<void, List<AdQuery>> getAllAdsCommand;

  DashboardViewmodel(this._getAllAdsUsecase) {
    getAllAdsCommand = Command.createAsync<void, List<AdQuery>>(
      _getAllAds,
      initialValue: [],
    );
    // getAllAdsCommand.execute();
  }

  Future<List<AdQuery>> _getAllAds(_) async {
    await Future.delayed(const Duration(seconds: 2));
    final result = await _getAllAdsUsecase(
      filters: CustomQueryBuilder(
        tableName: keyAdTable,
        includes: ['user', 'category'],
      ),
    );
    result.fold((l) => throw l, (data) => data);
    return result.getOrElse(() => []);
  }
}
