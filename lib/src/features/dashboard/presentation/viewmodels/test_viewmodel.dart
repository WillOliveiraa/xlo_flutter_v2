import 'package:command_it/command_it.dart';

class TestViewmodel {
  int _counter = 0;
  int get counter => _counter;
  late Command<void, int> incrementCounterCommand;

  TestViewmodel() {
    incrementCounterCommand = Command.createAsync<void, int>(
      increment,
      initialValue: 0,
    );
  }

  Future<int> increment(_) async {
    await Future.delayed(const Duration(seconds: 2));
    _counter++;
    // notifyListeners();
    return _counter;
  }
}
