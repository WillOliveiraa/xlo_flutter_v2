import 'package:command_it/command_it.dart';
import 'package:xlo_flutter_v2/src/features/auth/application/usecases/get_current_user.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

class AuthViewModel {
  final GetCurrentUser _getCurrentUserUseCase;
  late final Command<void, User?> getCurrentUserCommand;
  late final Command<bool, bool> isUserLoggedIn;
  User? _user;
  bool _isUserLoggedIn = false;

  AuthViewModel(this._getCurrentUserUseCase) {
    getCurrentUserCommand = Command.createAsync(
      _getCurrentUser,
      initialValue: null,
    );
    getCurrentUserCommand.execute();
    isUserLoggedIn = Command.createSync<bool, bool>(
      (t) => t,
      initialValue: false,
    );
  }

  void setIsUserLoggedIn(bool value) => _isUserLoggedIn = value;

  bool get isUserLoggedInn => _isUserLoggedIn;

  void setUser(User? value) => _user = value;

  User? get user => _user;

  Future<User?> _getCurrentUser(_) async {
    final result = await _getCurrentUserUseCase();
    await Future.delayed(const Duration(seconds: 8));
    return result.fold((l) => throw l, (data) {
      setUser(data);
      final hasData = data != null;
      isUserLoggedIn.execute(hasData);
      setIsUserLoggedIn(hasData);
      return data;
    });
  }
}
