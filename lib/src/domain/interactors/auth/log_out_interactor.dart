import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/auth_repository.dart';

@LazySingleton()
class LogOutInteractor extends BaseNoInputInteractor<void> {
  LogOutInteractor(this.repository);

  AuthRepository repository;

  @override
  Future<void> call() async {
    return repository.logOut();
  }
}
