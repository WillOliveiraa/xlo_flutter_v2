import 'package:lucid_validation/lucid_validation.dart';

import 'failure.dart';

class CustomArgumentError extends Failure {
  final List<ValidationException> exceptions;

  CustomArgumentError({required this.exceptions});
}
