import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:xlo_flutter_v2/src/core/utils/contants.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/get_all_categories.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_category.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/ad/gateways/category_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/http/parse_server_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParseServer();

  final httpClient = ParseServerAdapter();
  final categoryGateway = CategoryGatewayImpl(httpClient);
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

  // final parseObject = ParseObject(keyCategoryTable);
  // final response = await parseObject.getAll();
  // if (response.success) {
  //   final list = response.results ?? [];
  //   for (var element in list) {
  //     final map = element.toJson() as Map<String, dynamic>;
  //     debugPrint('Category: ${map['description']}');
  //   }
  // } else {
  //   debugPrint(response.error?.message);
  // }

  runApp(const MyApp());
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
