import 'package:lucid_validation/lucid_validation.dart';

class LoginInput extends LoginInputValidator {
  late String _email;
  late String _password;

  LoginInput({required String email, required String password}) {
    _email = email;
    _password = password;
  }

  String get email => _email;

  setEmail(String value) => _email = value;

  String get password => _password;

  setPassword(String value) => _password = value;

  factory LoginInput.empty() => LoginInput(email: '', password: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  factory LoginInput.fromMap(Map<String, dynamic> map) {
    return LoginInput(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}

class LoginInputValidator extends LucidValidator<LoginInput> {
  LoginInputValidator() {
    ruleFor((user) => user.email.trim(), key: 'email')
        .notEmpty(message: 'Email is required')
        .validEmail(message: 'Invalid email format');
    ruleFor(
      (user) => user.password.trim(),
      key: 'password',
    ).notEmpty(message: 'Password is required');
  }
}
