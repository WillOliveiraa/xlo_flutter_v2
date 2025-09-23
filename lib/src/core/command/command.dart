import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

abstract class Command<TFailure, TSuccess> extends ChangeNotifier {
  bool _isExecuting = false;

  bool get isExecuting => _isExecuting;

  Either<TFailure, TSuccess>? _result;

  bool get isSuccess => _result is Right;

  bool get isFailure => _result is Left;

  Future<void> _execute(
    Future<Either<TFailure, TSuccess>> Function() action,
  ) async {
    if (_isExecuting) return;
    _isExecuting = true;
    _result = null;
    notifyListeners();
    _result = await action();
    _isExecuting = false;
    notifyListeners();
  }
}

class Command0<TFailure, TSuccess> extends Command<TFailure, TSuccess> {
  final Future<Either<TFailure, TSuccess>> Function() _action;

  Command0(this._action);

  Future<void> execute() async => _execute(_action);
}

class Command1<TFailure, TSuccess, TParam> extends Command<TFailure, TSuccess> {
  final Future<Either<TFailure, TSuccess>> Function(TParam) _action;

  Command1(this._action);

  Future<void> execute(TParam param) async => _execute(() => _action(param));
}
