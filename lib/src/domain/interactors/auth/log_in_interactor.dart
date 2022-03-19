import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/auht/login_params.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/auth_repository.dart';

@LazySingleton()
class LogInInteractor extends BaseInteractor<LoginParams, void> {
  LogInInteractor(this.repository);

  AuthRepository repository;

  @override
  Future<void> call(LoginParams input) async {
    return repository.logIn(input);
  }
}
