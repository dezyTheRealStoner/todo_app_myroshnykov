part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  const AuthState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmedPassword = '',
    this.loginStatus = true,
    this.allFieldsFilled = false,
    this.invalidUsername = false,
    this.invalidEmail = false,
    this.invalidPassword = false,
    this.invalidConfirmedPassword = false,
    this.emailAlreadyUsed = false,
    this.incorrectEmailOrPassword = false,
    this.allIsValid = false,
    this.progress = false,
  });

  final String name;
  final String email;
  final String password;
  final String confirmedPassword;

  final bool loginStatus;
  final bool allFieldsFilled;
  final bool invalidUsername;
  final bool invalidEmail;
  final bool invalidPassword;
  final bool invalidConfirmedPassword;
  final bool emailAlreadyUsed;
  final bool incorrectEmailOrPassword;
  final bool allIsValid;
  final bool progress;

  AuthState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmedPassword,
    bool? loginStatus,
    bool? allFieldsFilled,
    bool? invalidUsername,
    bool? invalidEmail,
    bool? invalidPassword,
    bool? invalidConfirmedPassword,
    bool? emailAlreadyUsed,
    bool? incorrectEmailOrPassword,
    bool? allIsValid,
    bool? progress,
  }) {
    return AuthState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      loginStatus: loginStatus ?? this.loginStatus,
      allFieldsFilled: allFieldsFilled ?? this.allFieldsFilled,
      invalidUsername: invalidUsername ?? this.invalidUsername,
      invalidEmail: invalidEmail ?? this.invalidEmail,
      invalidPassword: invalidPassword ?? this.invalidPassword,
      invalidConfirmedPassword:
          invalidConfirmedPassword ?? this.invalidConfirmedPassword,
      emailAlreadyUsed: emailAlreadyUsed ?? this.emailAlreadyUsed,
      incorrectEmailOrPassword:
          incorrectEmailOrPassword ?? this.incorrectEmailOrPassword,
      allIsValid: allIsValid ?? this.allIsValid,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        confirmedPassword,
        loginStatus,
        allFieldsFilled,
        invalidUsername,
        invalidEmail,
        invalidPassword,
        invalidConfirmedPassword,
        emailAlreadyUsed,
        incorrectEmailOrPassword,
        allIsValid,
        progress,
      ];
}
