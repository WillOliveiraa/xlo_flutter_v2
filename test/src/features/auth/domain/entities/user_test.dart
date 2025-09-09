import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/enum/user_type.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/sign_up_user.dart';

import '../../../../mocks/user_mock.dart';

void main() {
  group('should check if field is valid or not', () {
    final skip = false;
    test('should create a valid [SignUpEntity]', () {
      final ad = SignUpEntity.fromMap(usersMock.first);
      expect(ad, isA<SignUpEntity>());
      expect(ad.id, '1');
      expect(ad.name, 'John Doe');
      expect(ad.email, 'john.doe@gmail.com');
      expect(ad.password, 'Password123@');
      expect(ad.phone, '123-456-7890');
      expect(ad.type, UserType.particular);
      expect(ad.image, isNull);
    }, skip: skip);

    parameterizedTest(
      'when validating [SignUpEntity] with invalid name',
      ['', ' ', 'Wi'],
      (String value) {
        final ad = SignUpEntity(
          id: usersMock.first['id'],
          name: value,
          email: usersMock.first['email'],
          password: usersMock.first['password'],
          phone: usersMock.first['phone'],
        );
        final result = ad.validate(ad);
        expect(result.isValid, isFalse);
        if (value != 'Wi') {
          expect(result.exceptions.length, 2);
          expect(
            result.exceptions.any((e) => e.message == 'Name is required'),
            isTrue,
          );
        }
        expect(
          result.exceptions.any(
            (e) => e.message == 'Name must be at least 3 characters long',
          ),
          isTrue,
        );
      },
      skip: skip,
    );

    parameterizedTest(
      'when validating [SignUpEntity] with invalid email',
      ['', ' ', 'invalidemail', 'user@domain', 'user@.com'],
      (String value) {
        final ad = SignUpEntity(
          id: usersMock.first['id'],
          name: usersMock.first['name'],
          email: value,
          password: usersMock.first['password'],
          phone: usersMock.first['phone'],
        );
        final result = ad.validate(ad);
        expect(result.isValid, isFalse);
        if (value.length < 2) {
          expect(result.exceptions.length, 2);
          expect(
            result.exceptions.any((e) => e.message == 'Email is required'),
            isTrue,
          );
        }
        expect(
          result.exceptions.any((e) => e.message == 'Invalid email format'),
          isTrue,
        );
      },
      skip: skip,
    );

    parameterizedTest(
      'when validating [SignUpEntity] with invalid password',
      [
        ['', 'empty'],
        [' ', 'empty'],
        ['short', 'short'],
        ['nouppercase1@', 'noUppercase'],
        ['NOLOWERCASE1@', 'noLowercase'],
        ['NoNumber@', 'noNumber'],
        ['NoSpecial1', 'noSpecial'],
      ],
      (String value, String caseName) {
        final ad = SignUpEntity(
          id: usersMock.first['id'],
          name: usersMock.first['name'],
          email: usersMock.first['email'],
          password: value,
          phone: usersMock.first['phone'],
        );
        final result = ad.validate(ad);
        expect(result.isValid, isFalse);
        switch (caseName) {
          case 'empty':
            return expect(
              result.exceptions.any((e) => e.message == 'Password is required'),
              isTrue,
            );
          case 'short':
            return expect(
              result.exceptions.any(
                (e) =>
                    e.message == 'Password must be at least 6 characters long',
              ),
              isTrue,
            );
          case 'noLowercase':
            return expect(
              result.exceptions.any(
                (e) =>
                    e.message ==
                    'Password must contain at least one lowercase letter',
              ),
              isTrue,
            );
          case 'noUppercase':
            return expect(
              result.exceptions.any(
                (e) =>
                    e.message ==
                    'Password must contain at least one uppercase letter',
              ),
              isTrue,
            );
          case 'noNumber':
            return expect(
              result.exceptions.any(
                (e) => e.message == 'Password must contain at least one number',
              ),
              isTrue,
            );
          case 'noSpecial':
            return expect(
              result.exceptions.any(
                (e) =>
                    e.message ==
                    'Password must contain at least one special character',
              ),
              isTrue,
            );
        }
      },
    );
  });
}
