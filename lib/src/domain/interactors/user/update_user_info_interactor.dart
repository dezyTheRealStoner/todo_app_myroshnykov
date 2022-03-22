import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/user_repository.dart';

@LazySingleton()
class UpdateUserInfoInteractor extends BaseInteractor<User, void> {
  UpdateUserInfoInteractor(this._repository);

  final UserRepository _repository;

  @override
  Future<void> call(User user) {
    return _repository.updateUserInfo(user);
  }
}
