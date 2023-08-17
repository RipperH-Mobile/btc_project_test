
import '../user_session.dart';

class Injector {
  static final Injector _appInjector = Injector._internal();


  static final UserSession _userSession = UserSession();

  factory Injector() => _appInjector;

  Injector._internal();

  UserSession get userSession {
    return _userSession;
  }
}
