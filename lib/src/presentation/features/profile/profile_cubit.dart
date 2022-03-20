import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/auth/log_out_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/user/get_user_info_interactor.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._logOutInteractor,
    this._getUserInfoInteractor,
  ) : super(const ProfileState());

  final LogOutInteractor _logOutInteractor;
  final GetUserInfoInteractor _getUserInfoInteractor;

  final logger = getLogger('ProfileCubit');

  Future<void> getProfileInfo() async {
    try {
      emit(state.copyWith(updating: true));

      final user = await _getUserInfoInteractor.call();

      emit(state.copyWith(user: user));
    } on Exception catch (error) {
      logger.e(error);
    } finally {
      emit(state.copyWith(updating: false));
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
