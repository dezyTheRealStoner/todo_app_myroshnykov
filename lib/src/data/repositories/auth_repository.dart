import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/auth_data_source.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/auht/login_params.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/auht/register_params.dart';
import 'package:todo_app_myroshnykov/src/domain/exceptions/email_is_already_user_exception.dart';
import 'package:todo_app_myroshnykov/src/domain/exceptions/incorrect_email_or_password_exception.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/auth_repository.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authDataSource);

  final AuthDataSource _authDataSource;

  final logger = getLogger('AuthRepository');

  @override
  Future<void> logIn(LoginParams params) async {
    try {
      await _authDataSource.logInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
    } on Exception catch (error) {
      if (error.hashCode == 185768934) {
        throw IncorrectEmailOrPasswordException();
      }
      logger.e('$error, hash code: ${error.hashCode}');
    }
  }

  @override
  Future<void> register(RegisterParams params) async {
    try {
      await _authDataSource.registerWithEmailAndPassword(
        email: params.email,
        name: params.name,
        password: params.password,
      );
    } on Exception catch (error) {
      if (error.hashCode == 34618382) {
        throw EmailIsAlreadyUsedException();
      }
      logger.e('$error, hash code: ${error.hashCode}');
    }
  }

  @override
  Future<bool> userIsLogged() async {
    try {
      return _authDataSource.isUserLogged();
    } on Exception {
      throw Exception();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _authDataSource.logOut();
    } on Exception {
      throw Exception();
    }
  }
}
