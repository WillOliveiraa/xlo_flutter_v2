import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

import '../../../../mocks/ad_mock.dart';

void main() {
  group('should check if field is valid or not', () {
    final skip = true;
    test('should create a valid [Ad]', () {
      final ad = Ad.fromMap(adsMocks.first);
      expect(ad, isA<Ad>());
      expect(ad.status, AdStatus.active);
      expect(ad.category.id, '1');
      expect(ad.owner.id, '1');
      expect(ad.images.length, 2);
    }, skip: skip);

    parameterizedTest('when validating [Ad] with invalid title', ['', ' '], (
      String value,
    ) {
      final ad = Ad(
        id: adsMocks.first['id'],
        title: value,
        description: adsMocks.first['description'],
        price: adsMocks.first['price'],
        images: adsMocks.first['images'],
        category: Category.fromMap(adsMocks.first['category']),
        owner: User.fromMap(adsMocks.first['owner']),
      );
      final result = ad.validate(ad);
      expect(result.isValid, isFalse);
      expect(result.exceptions.length, 2);
      expect(
        result.exceptions.any((e) => e.message == 'Title is required'),
        isTrue,
      );
    }, skip: skip);

    parameterizedTest(
      'when validating [Ad] with invalid description',
      ['', ' ', 'Short'],
      (String value) {
        final ad = Ad(
          id: adsMocks.first['id'],
          title: adsMocks.first['title'],
          description: value,
          price: adsMocks.first['price'],
          images: adsMocks.first['images'],
          category: Category.fromMap(adsMocks.first['category']),
          owner: User.fromMap(adsMocks.first['owner']),
        );
        final result = ad.validate(ad);
        expect(result.isValid, isFalse);
        if (value.length < 2) {
          expect(result.exceptions.length, 3);
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
                e.message == 'Description must be at least 10 characters long',
          ),
          isTrue,
        );
      },
      skip: skip,
    );

    parameterizedTest('when validating [Ad] with invalid price', [0.0, -10.0], (
      double value,
    ) {
      final ad = Ad(
        id: adsMocks.first['id'],
        title: adsMocks.first['title'],
        description: adsMocks.first['description'],
        price: value,
        images: adsMocks.first['images'],
        category: Category.fromMap(adsMocks.first['category']),
        owner: User.fromMap(adsMocks.first['owner']),
      );
      final result = ad.validate(ad);
      expect(result.isValid, isFalse);
      expect(
        result.exceptions.any(
          (e) => e.message == 'Price must be greater than 0',
        ),
        isTrue,
      );
    }, skip: skip);
  });
}
