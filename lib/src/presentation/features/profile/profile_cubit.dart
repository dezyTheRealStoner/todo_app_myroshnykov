import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/app/app_preferences_cubit.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_language.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_theme.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/auth/log_out_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/get_all_user_todos_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/user/get_user_info_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/user/update_user_info_interactor.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._logOutInteractor,
    this._updateUserInfoInteractor,
    this._getUserInfoInteractor,
    this._getAllUserTodosInteractor,
    this._appPreferencesCubit,
  ) : super(const ProfileState());

  final LogOutInteractor _logOutInteractor;
  final UpdateUserInfoInteractor _updateUserInfoInteractor;
  final GetUserInfoInteractor _getUserInfoInteractor;
  final GetAllUserTodosInteractor _getAllUserTodosInteractor;
  final AppPreferencesCubit _appPreferencesCubit;

  final logger = getLogger('ProfileCubit');

  Future<void> getProfileInfo() async {
    try {
      emit(state.copyWith(updating: true));

      final user = await _getUserInfoInteractor.call();

      final todos = await _getAllUserTodosInteractor.call();

      int completedTodos = 0;

      for (var todo in todos) {
        if (todo.completed) {
          completedTodos++;
        }
      }

      emit(state.copyWith(
        user: user,
        completedTodos: completedTodos,
      ));

      setTheme(user.theme);
      setLanguage(user.language);
    } on Exception catch (error) {
      logger.e(error);
    } finally {
      emit(state.copyWith(updating: false));
    }
  }

  void onTapLanguageButton() {
    if (state.openLanguageButton) {
      emit(state.copyWith(openLanguageButton: false));
    } else {
      emit(state.copyWith(openLanguageButton: true));
    }
  }

  void onTapThemeButton() {
    if (state.openThemeButton) {
      emit(state.copyWith(openThemeButton: false));
    } else {
      emit(state.copyWith(openThemeButton: true));
    }
  }

  void setLanguage(UserLanguage language) {
    if (language == UserLanguage.en) {
      emit(state.copyWith(
        englishLanguageSelected: true,
        ukrainianLanguageSelected: false,
      ));
    } else if (language == UserLanguage.uk) {
      emit(state.copyWith(
        englishLanguageSelected: false,
        ukrainianLanguageSelected: true,
      ));
    }
  }

  void setTheme(UserTheme theme) {
    if (theme == UserTheme.light) {
      emit(state.copyWith(
        lightThemeSelected: true,
        darkThemeSelected: false,
      ));
    } else if (theme == UserTheme.dark) {
      emit(state.copyWith(
        lightThemeSelected: false,
        darkThemeSelected: true,
      ));
    }
  }

  Future<void> onThemeSelected(UserTheme theme) async {
    try {
      await _updateUserInfoInteractor.call(state.user.copyWith(theme: theme));
      await _appPreferencesCubit.getUserInfo();
      setTheme(theme);
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  Future<void> onLanguageSelected(UserLanguage language) async {
    try {
      await _updateUserInfoInteractor
          .call(state.user.copyWith(language: language));
      await _appPreferencesCubit.getUserInfo();
      setLanguage(language);
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  Future<void> onLogOut() async {
    try {
      await _logOutInteractor.call();
    } on Exception catch (error) {
      logger.e(error);
    }
  }
}
