import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xlo_flutter_v2/src/core/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/get_all_ads.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/get_all_categories.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/category_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/ad/presentation/viewmodels/ad_viewmodel.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/get_current_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/infra/gateway/user_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/sign_up_viewmodel.dart';
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
        create:
            (context) => UserGatewayHttp(context.read<ParseServerAdapter>()),
      ),
      Provider(
        create: (context) => AdGatewayHttp(context.read<ParseServerAdapter>()),
      ),
      Provider(
        create:
            (context) =>
                CategoryGatewayHttp(context.read<ParseServerAdapter>()),
      ),
      ..._initializeAuth(),
      ..._initializeUser(),
      ..._initializeAd(),
    ];
  }

  List<SingleChildWidget> _initializeAuth() {
    return [
      /*
        USECASES
      */
      Provider(
        create: (context) => GetCurrentUser(context.read<UserGatewayHttp>()),
      ),
      /*
        VIEWMODELS
      */
      Provider(
        create: (context) => AuthViewModel(context.read<GetCurrentUser>()),
        lazy: true,
      ),
    ];
  }

  List<SingleChildWidget> _initializeUser() {
    return [
      /*
        USECASES
      */
      Provider(create: (context) => Login(context.read<UserGatewayHttp>())),
      Provider(
        create: (context) => SignUpUser(context.read<UserGatewayHttp>()),
      ),
      /*
        VIEWMODELS
      */
      Provider(create: (context) => LoginViewmodel(context.read<Login>())),
      Provider(
        create: (context) => SignUpViewmodel(context.read<SignUpUser>()),
      ),
    ];
  }

  List<SingleChildWidget> _initializeAd() {
    return [
      /*
        USECASES
      */
      Provider(create: (context) => GetAllAds(context.read<AdGatewayHttp>())),
      Provider(create: (context) => SaveAd(context.read<AdGatewayHttp>())),
      Provider(
        create:
            (context) => GetAllCategories(context.read<CategoryGatewayHttp>()),
      ),
      /*
        VIEWMODELS
      */
      Provider(
        create: (context) => DashboardViewmodel(context.read<GetAllAds>()),
      ),
      Provider(
        create:
            (context) => AdViewmodel(
              context.read<SaveAd>(),
              context.read<GetAllCategories>(),
            ),
      ),
    ];
  }
}
