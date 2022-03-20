import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/auth_repository.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(ProfileState());

  final AuthRepository _repository;

  final logger = getLogger('ProfileCubit');

  Future<void> onLogOut() async {
    try {
      await _repository.logOut();
    } on Exception catch (error) {
      logger.e(error);
    }
  }
}
