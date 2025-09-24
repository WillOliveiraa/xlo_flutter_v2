import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xlo_flutter_v2/src/core/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/get_all_ads.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/infra/gateway/user_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';

class AppInitialization {
  AppInitialization();

  List<SingleChildWidget> initializeInjectDependencies() {
    return [
      Provider(create: (context) => ParseServerAdapter()),
      ..._initializeViewmodels(),
    ];
  }

  List<SingleChildWidget> _initializeViewmodels() {
    return [
      /*
        GATEWAYS
      */
      Provider(
        create: (context) => AdGatewayHttp(context.read<ParseServerAdapter>()),
      ),
      Provider(
        create:
            (context) => UserGatewayHttp(context.read<ParseServerAdapter>()),
      ),

      /*
        USECASES
      */
      Provider(create: (context) => GetAllAds(context.read<AdGatewayHttp>())),
      Provider(create: (context) => Login(context.read<UserGatewayHttp>())),

      /*
        VIEWMODELS
      */
      Provider(
        create: (context) => DashboardViewmodel(context.read<GetAllAds>()),
      ),
      Provider(create: (context) => LoginViewmodel(context.read<Login>())),
    ];
  }
}
