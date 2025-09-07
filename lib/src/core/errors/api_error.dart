import 'failure.dart';

class ApiError implements Failure {
  ApiError({required String message});

  @override
  String get message => message;
}
