part of 'app_preferences_cubit.dart';

@immutable
class AppPreferencesState extends Equatable {
  const AppPreferencesState({
    this.userIsLogged = false,
    this.user = mockedUser,
  });

  final User user;
  final bool userIsLogged;

  AppPreferencesState copyWith({
    bool? userIsLogged,
    User? user,
  }) {
    return AppPreferencesState(
      user: user ?? this.user,
      userIsLogged: userIsLogged ?? this.userIsLogged,
    );
  }

  @override
  List<Object?> get props => [
        userIsLogged,
        user,
      ];
}
