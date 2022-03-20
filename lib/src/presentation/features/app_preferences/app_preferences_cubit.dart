import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/auth/user_is_logged_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/user/get_user_info_interactor.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

part 'app_preferences_state.dart';

@injectable
class AppPreferencesCubit extends Cubit<AppPreferencesState> {
  AppPreferencesCubit(
    this._userIsLoggedInteractor,
    this._getUserInfoInteractor,
  ) : super(const AppPreferencesState());

  final UserIsLoggedInteractor _userIsLoggedInteractor;
  final GetUserInfoInteractor _getUserInfoInteractor;

  final logger = getLogger('AppPreferencesCubit');

  Future<void> checkUserAuthStatus() async {
    final userIsLogged = await _userIsLoggedInteractor.call();

    logger.i(userIsLogged);

    emit(state.copyWith(userIsLogged: userIsLogged));

    if (state.userIsLogged) {
      getUserInfo();
    }
  }

  Future<void> getUserInfo() async {
    try {
      final user = await _getUserInfoInteractor.call();
      emit(state.copyWith(user: user));
      logger.i(state.user);
    } on Exception catch (error) {
      logger.e(error);
    }
  }
}
