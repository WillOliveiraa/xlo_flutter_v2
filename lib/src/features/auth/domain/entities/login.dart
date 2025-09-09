import 'package:lucid_validation/lucid_validation.dart';

class LoginInput extends LucidValidator<LoginInput> {
  final String email;
  final String password;

  LoginInput(this.email, this.password) {
    ruleFor((user) => user.email.trim(), key: 'email')
        .notEmpty(message: 'Email is required')
        .validEmail(message: 'Invalid email format');
    ruleFor((user) => user.password.trim(), key: 'password')
        .notEmpty(message: 'Password is required')
        .minLength(6, message: 'Password must be at least 6 characters long');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  factory LoginInput.fromMap(Map<String, dynamic> map) {
    return LoginInput(map['email'] as String, map['password'] as String);
  }
}
