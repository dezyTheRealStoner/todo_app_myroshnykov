import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/todo_repository.dart';

@LazySingleton()
class GetActualTodosInteractor extends BaseNoInputInteractor<List<Todo>> {
  GetActualTodosInteractor(this._repository);

  final TodoRepository _repository;

  @override
  Future<List<Todo>> call() {
    return _repository.getActualTodos();
  }
}
