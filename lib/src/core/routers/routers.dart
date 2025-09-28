import 'package:xlo_flutter_v2/src/features/ad/presentation/pages/ad_page.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/pages/login_page.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/base_page.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/test_page.dart';

class Routers {
  static const String initial = '/';
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String signUp = '/sign_up';
  static const String ad = '/ad';
  static const String test = '/test';
}

final routes = {
  Routers.initial: (context) => const BasePage(),
  Routers.dashboard: (context) => const DashboardPage(),
  Routers.test: (context) => const TestPage(),
  Routers.login: (context) => const LoginPage(),
  Routers.signUp: (context) => const SignUpPage(),
  Routers.ad: (context) => const AdPage(),
};
