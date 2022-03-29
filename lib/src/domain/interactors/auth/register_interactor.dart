import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/auht/register_params.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/auth_repository.dart';

@LazySingleton()
class RegisterInteractor extends BaseInteractor<RegisterParams, void> {
  RegisterInteractor(this.repository);

  AuthRepository repository;

  @override
  Future<void> call(RegisterParams input) async {
    return repository.register(input);
  }
}
