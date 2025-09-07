import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';

import '../../../../mocks/ad_mock.dart';

void main() {
  group('should check if field is valid or not', () {
    test('should create a valid [Category]', () {
      final ad = Category.fromMap(categoriesMock.first);
      expect(ad, isA<Category>());
      expect(ad.id, '1');
      expect(ad.description, 'Electronics');
    });

    parameterizedTest(
      'when validating [Category] with invalid description',
      ['', ' ', 'ab'],
      (String value) {
        final ad = Category(description: value);
        final result = ad.validate(ad);
        expect(result.isValid, isFalse);
        if (value != 'ab') {
          expect(result.exceptions.length, 2);
          expect(
            result.exceptions.any(
              (e) => e.message == 'Description is required',
            ),
            isTrue,
          );
        }
        expect(
          result.exceptions.any(
            (e) =>
                e.message == 'Description must be at least 3 characters long',
          ),
          isTrue,
        );
      },
    );
  });
}
