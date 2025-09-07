import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/usecases/save_category.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/ad/gateways/category_gateway.dart';
import 'package:xlo_flutter_v2/src/features/ad/http/parse_server_adapter.dart';

class MockParseServerAdapter extends Mock implements ParseServerAdapter {}

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  // setUpAll(() async {
  //   await setupParseInstance();
  //   // Add this if your app uses MethodChannels that require plugin registration
  //   // TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
  //   //     .setMockMethodCallHandler(
  //   //       MethodChannel('dev.fluttercommunity.plus/package_info'),
  //   //       (MethodCall methodCall) async => null,
  //   //     );
  // });

  final httpClient = MockParseServerAdapter();
  final categoryGateway = CategoryGatewayImpl(httpClient);
  final saveCategory = SaveCategory(categoryGateway);
  final category = Category(id: '1', description: 'Eletrônicos');

  test('should save a new category', () async {
    // arrange
    when(
      () => categoryGateway.save(category),
    ).thenAnswer((_) async => const Right(unit));

    // act
    final result = (await saveCategory(category)).fold((l) => null, (r) => r);

    //assert
    expect(result, unit);
  });
}
