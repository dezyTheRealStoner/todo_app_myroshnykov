import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/todo_repository.dart';

@LazySingleton()
class RemoveTodoInteractor extends BaseInteractor<String, void> {
  RemoveTodoInteractor(this._repository);

  final TodoRepository _repository;

  @override
  Future<void> call(String id) {
    return _repository.removeTodo(id);
  }
}
