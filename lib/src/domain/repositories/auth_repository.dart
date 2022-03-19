import 'package:todo_app_myroshnykov/src/domain/entities/auht/login_params.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/auht/register_params.dart';

abstract class AuthRepository {
  Future<void> logIn(LoginParams params);

  Future<void> register(RegisterParams params);

  Future<bool> userIsLogged();

  Future<void> logOut();
}
