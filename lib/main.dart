import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/errors/custom_argument_error.dart';
import 'package:xlo_flutter_v2/src/core/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/core/utils/contants.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/get_all_categories.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_category.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/category_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/get_user_by_id.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/login.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';
import 'package:xlo_flutter_v2/src/features/auth/infra/gateway/user_gateway_http.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParseServer();

  final httpClient = ParseServerAdapter();

  // await saveCategories(httpClient);
  await saveAd(httpClient);
  // await signUpUser(httpClient);
  // await getUserById(httpClient);
  // await login(httpClient);

  runApp(const MyApp());
}

Future<void> login(ParseServerAdapter httpClient) async {
  final userGateway = UserGatewayHttp(httpClient);
  final login = Login(userGateway);
  final input = LoginInput('john.doe@gmail.com', 'Password123@');
  final result = await login(input);
  result.fold(
    (l) => debugPrint('Error: ${l.toString()}'),
    (data) => debugPrint('User: ${data.toMap()}'),
  );
}

Future<void> getUserById(ParseServerAdapter httpClient) async {
  final userGateway = UserGatewayHttp(httpClient);
  final getUserById = GetUserById(userGateway);
  final input = 'yUHeNHJAEe';
  final result = await getUserById(input);
  result.fold(
    (l) => l,
    (data) => {if (data != null) debugPrint('User: ${data.toMap()}')},
  );
}

Future<void> signUpUser(ParseServerAdapter httpClient) async {
  final userGateway = UserGatewayHttp(httpClient);
  final signUp = SignUpUser(userGateway);
  final user = SignUpEntity(
    name: 'John Doe',
    email: 'john.doe@gmail.com',
    phone: '11999999999',
    password: 'Password123@',
  );
  final result = await signUp(user);
  result.fold((l) {
    if (l is CustomArgumentError) {
      for (var exception in l.exceptions) {
        debugPrint('Validation error: ${exception.message}');
      }
    }
  }, (r) => debugPrint('User signed up successfully!'));
}

Future<void> saveCategories(ParseServerAdapter httpClient) async {
  final categoryGateway = CategoryGatewayHttp(httpClient);
  final getAllCategories = GetAllCategories(categoryGateway);
  final saveCategory = SaveCategory(categoryGateway);
  // final category = Category(description: 'Eletrônicos');
  // final category2 = Category(description: 'Veículos');
  final category3 = Category(description: 'Imóveis');
  // (await saveCategory(category3)).fold((l) => null, (r) => r);

  final result = await getAllCategories();
  result.fold(
    (l) => debugPrint('Error: ${l.toString()}'),
    (r) => r.forEach((category) {
      debugPrint('Category: ${category.description}, ID: ${category.id}');
    }),
  );
}

Future<void> saveAd(ParseServerAdapter httpClient) async {
  final adGateway = AdGatewayHttp(httpClient);
  final saveAd = SaveAd(adGateway);
  final ad = Ad(
    title: 'Ad Title 1',
    description: 'Ad Description 1',
    price: 100.0,
    category: Category(id: '35UDuNGElA', description: 'Imóveis'),
    images: [],
    owner: User(
      id: 'yUHeNHJAEe',
      name: 'John Doe',
      email: 'john.doe@gmail.com',
      phone: '11999999999',
    ),
  );
  final result = await saveAd(ad);
  result.fold((l) {
    if (l is CustomArgumentError) {
      debugPrint(l.exceptions.first.message);
    } else if (l is ApiError) {
      debugPrint(l.message);
    }
  }, (r) => debugPrint('Ad saved succefully'));
}

Future<void> initializeParseServer() async {
  await Parse().initialize(
    keyParseApplicationId,
    keyParseServerUrl,
    clientKey: keyParseClientKey,
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(body: Center(child: Text('Flutter Demo Home Page'))),
    );
  }
}
