import 'package:xlo_flutter_v2/src/features/auth/presentation/pages/login_page.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/test_page.dart';

class Routers {
  static const String dashboard = '/';
  static const String login = '/login';
  static const String ad = '/ad';
  static const String test = '/test';
}

final routes = {
  Routers.dashboard: (context) => const DashboardPage(),
  Routers.test: (context) => const TestPage(),
  Routers.login: (context) => const LoginPage(),
};
