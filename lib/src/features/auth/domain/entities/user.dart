import 'package:lucid_validation/lucid_validation.dart';

import './enum/user_type.dart';

class User extends LucidValidator<User> {
  final String id;
  final String name;
  final String email;
  final UserType type;
  final String phone;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.type = UserType.particular,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'type': type.name,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      type: UserType.values.firstWhere(
        (e) => e.name == (map['type'] as String),
        orElse: () => UserType.particular,
      ),
      image: map['image'] as String?,
    );
  }
}
