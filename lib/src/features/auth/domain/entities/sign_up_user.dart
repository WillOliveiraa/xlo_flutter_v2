import 'package:lucid_validation/lucid_validation.dart';

import './enum/user_type.dart';

class SignUpEntity extends LucidValidator<SignUpEntity> {
  final String? id;
  final String name;
  final String email;
  final String password;
  final UserType type;
  final String phone;
  final String? image;

  SignUpEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.type = UserType.particular,
    this.image,
  }) {
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
