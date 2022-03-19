import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/auht/login_params.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/auht/register_params.dart';
import 'package:todo_app_myroshnykov/src/domain/exceptions/email_is_already_user_exception.dart';
import 'package:todo_app_myroshnykov/src/domain/exceptions/incorrect_email_or_password_exception.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/auth/log_in_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/auth/register_interactor.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/validators.dart';

part 'auth_state.dart';

@Injectable()
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._logInInteractor,
    this._registerInteractor,
  ) : super(const AuthState());

  final LogInInteractor _logInInteractor;
  final RegisterInteractor _registerInteractor;

  final logger = getLogger('AuthCubit');

  void _checkAllFieldsFilled() {
    state.loginStatus
        ? emit(state.copyWith(
            allFieldsFilled:
                state.email.isNotEmpty && state.password.isNotEmpty))
        : emit(state.copyWith(
            allFieldsFilled: state.email.isNotEmpty &&
                state.name.isNotEmpty &&
                state.password.isNotEmpty &&
                state.confirmedPassword.isNotEmpty,
          ));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(
      email: email,
      invalidEmail: false,
      emailAlreadyUsed: false,
    ));
    _checkAllFieldsFilled();
  }

  void onNameChanged(String name) {
    emit(state.copyWith(
      name: name,
      invalidUsername: false,
    ));
    _checkAllFieldsFilled();
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password, invalidPassword: false));
    _checkAllFieldsFilled();
  }

  void onRepeatedPasswordChanged(String confirmedPassword) {
    emit(state.copyWith(
        confirmedPassword: confirmedPassword, invalidConfirmedPassword: false));
    _checkAllFieldsFilled();
  }

  Future<void> onLogIn() async {
    final emailValid = validateEmail(state.email);

    if (emailValid) {
      try {
        final params = LoginParams(
          email: state.email,
          password: state.password,
        );

        emit(state.copyWith(progress: true));

        await _logInInteractor.call(params);

        emit(state.copyWith(allIsValid: true));
      } on IncorrectEmailOrPasswordException catch (error) {
        emit(state.copyWith(incorrectEmailOrPassword: true));
        logger.e(error);
      } on Exception catch (error) {
        logger.e(error.toString());
      } finally {
        emit(state.copyWith(progress: false));
      }
    } else {
      emit(state.copyWith(invalidEmail: !emailValid));
    }
  }

  Future<void> onRegister() async {
    final emailValid = validateEmail(state.email);
    final usernameValid = validateName(state.name);
    final passwordValid = validatePassword(state.password);
    final confirmedPasswordValid = validateConfirmedPassword(
      password: state.password,
      confirmedPassword: state.confirmedPassword,
    );

    if (emailValid &&
        usernameValid &&
        passwordValid &&
        confirmedPasswordValid) {
      try {
        final params = RegisterParams(
          name: state.name,
          email: state.email,
          password: state.password,
        );

        emit(state.copyWith(progress: true));

        await _registerInteractor.call(params);

        emit(state.copyWith(allIsValid: true));
      } on EmailIsAlreadyUsedException catch (error) {
        emit(state.copyWith(emailAlreadyUsed: true));
        logger.e(error);
      } on Exception catch (error) {
        logger.e(error);
      } finally {
        emit(state.copyWith(progress: false));
      }
    } else {
      emit(
        state.copyWith(
          invalidEmail: !emailValid,
          invalidUsername: !usernameValid,
          invalidPassword: !passwordValid,
          invalidConfirmedPassword: !confirmedPasswordValid,
        ),
      );
    }
  }

  void onChangeAuthState() async {
    state.loginStatus
        ? emit(state.copyWith(loginStatus: false))
        : emit(state.copyWith(loginStatus: true));

    _checkAllFieldsFilled();
  }
}
