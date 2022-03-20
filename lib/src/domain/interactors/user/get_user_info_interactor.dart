import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/user/user.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/user_repository.dart';

@LazySingleton()
class GetUserInfoInteractor extends BaseNoInputInteractor<User> {
  GetUserInfoInteractor(this._repository);

  final UserRepository _repository;

  @override
  Future<User> call() {
    return _repository.getUserInfo();
  }
}
