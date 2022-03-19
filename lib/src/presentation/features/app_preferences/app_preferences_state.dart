part of 'app_preferences_cubit.dart';

@immutable
class AppPreferencesState extends Equatable {
  const AppPreferencesState({this.userIsLogged = false});

  final bool userIsLogged;

  AppPreferencesState copyWith({bool? userIsLogged}) {
    return AppPreferencesState(
      userIsLogged: userIsLogged ?? this.userIsLogged,
    );
  }

  @override
  List<Object?> get props => [userIsLogged];
}
