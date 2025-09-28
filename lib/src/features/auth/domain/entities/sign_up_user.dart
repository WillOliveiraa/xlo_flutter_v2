import 'package:lucid_validation/lucid_validation.dart';

import './enum/user_type.dart';

class SignUpEntity extends SignUpInputValidator {
  late String? _id;
  late String _name;
  late String _email;
  late String _password;
  late UserType _type;
  late String _phone;
  late String? _image;

  SignUpEntity({
    String? id,
    required String name,
    required String email,
    required String password,
    required String phone,
    UserType type = UserType.particular,
    String? image,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _password = password;
    _phone = phone;
    _type = type;
    _image = image;
  }

  // ignore: unnecessary_getters_setters
  String? get id => _id;

  set setId(String? value) => _id = value;

  String get name => _name;

  setName(String value) => _name = value;

  String get email => _email;

  setEmail(String value) => _email = value;

  String get password => _password;

  setPassword(String value) => _password = value;

  UserType get type => _type;

  setType(UserType value) => _type = value;

  String get phone => _phone;

  setPhone(String value) => _phone = value;

  String? get image => _image;

  setImage(String value) => _image = value;

  factory SignUpEntity.empty() =>
      SignUpEntity(name: '', email: '', phone: '', password: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'type': type.name,
      'image': image,
    };
  }

  factory SignUpEntity.fromMap(Map<String, dynamic> map) {
    return SignUpEntity(
      id: map['id'] as String?,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      type: UserType.values.firstWhere(
        (e) => e.name == (map['type'] as String),
        orElse: () => UserType.particular,
      ),
      image: map['image'] as String?,
    );
  }
}

class SignUpInputValidator extends LucidValidator<SignUpEntity> {
  SignUpInputValidator() {
    ruleFor((user) => user.name.trim(), key: 'name')
        .notEmpty(message: 'Name is required')
        .minLength(3, message: 'Name must be at least 3 characters long');
    ruleFor((user) => user.email.trim(), key: 'email')
        .notEmpty(message: 'Email is required')
        .validEmail(message: 'Invalid email format');
    ruleFor((user) => user.password.trim(), key: 'password')
        .notEmpty(message: 'Password is required')
        .minLength(6, message: 'Password must be at least 6 characters long')
        .mustHaveLowercase(
          message: 'Password must contain at least one lowercase letter',
        )
        .mustHaveUppercase(
          message: 'Password must contain at least one uppercase letter',
        )
        .mustHaveNumber(message: 'Password must contain at least one number')
        .mustHaveSpecialCharacter(
          message: 'Password must contain at least one special character',
        );
    ruleFor((user) => user.phone.trim(), key: 'phone')
        .notEmpty(message: 'Phone is required')
        .minLength(10, message: 'Phone must be at least 10 characters long');
  }
}
