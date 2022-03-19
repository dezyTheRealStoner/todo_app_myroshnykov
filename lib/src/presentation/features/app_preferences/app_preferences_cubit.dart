import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/auth/user_is_logged_interactor.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';

part 'app_preferences_state.dart';

@injectable
class AppPreferencesCubit extends Cubit<AppPreferencesState> {
  AppPreferencesCubit(this._userIsLoggedInteractor)
      : super(const AppPreferencesState());

  final UserIsLoggedInteractor _userIsLoggedInteractor;

  final logger = getLogger('AppPreferencesCubit');

  Future<void> checkUserAuthStatus() async {
    final userIsLogged = await _userIsLoggedInteractor.call();

    logger.i(userIsLogged);

    emit(state.copyWith(userIsLogged: userIsLogged));
  }
}
