import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/auth_repository.dart';

@LazySingleton()
class UserIsLoggedInteractor extends BaseNoInputInteractor<bool> {
  UserIsLoggedInteractor(this.repository);

  AuthRepository repository;

  @override
  Future<bool> call() async {
    return repository.userIsLogged();
  }
}
