import 'package:command_it/command_it.dart';
import 'package:xlo_flutter_v2/src/core/http/custom_query_builder.dart';
import 'package:xlo_flutter_v2/src/core/utils/tables_keys.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/get_all_ads.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/types/ad_query.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';

class DashboardViewmodel {
  final AdGatewayHttp _adGateway;
  final List<AdQuery> _ads = [];
  late final Command<void, List<AdQuery>> getAllAdsCommand;
  // late final Command<Failure, List<AdQuery>> getAllAdsCommand;

  List<AdQuery> get ads => _ads;

  DashboardViewmodel(this._adGateway) {
    getAllAdsCommand = Command.createAsync<void, List<AdQuery>>(
      _getAllAds,
      initialValue: [],
    );
    getAllAdsCommand.execute();
    // getAllAdsCommand = Command0(_getAllAds);
  }

  // Future<Either<Failure, List<AdQuery>>> _getAllAds() async {
  Future<List<AdQuery>> _getAllAds(_) async {
    await Future.delayed(const Duration(seconds: 2));
    final getAllAds = GetAllAds(_adGateway);
    final result = await getAllAds(
      filters: CustomQueryBuilder(
        tableName: keyAdTable,
        includes: ['user', 'category'],
      ),
    );
    result.fold((l) => throw l, (data) => data);
    // notifyListeners();
    // return SuccessCommand(result);
    // return result;
    return result.getOrElse(() => []);
  }
}
