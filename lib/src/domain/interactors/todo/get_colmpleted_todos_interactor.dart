import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/todo_repository.dart';

class GetCompletedTodosInteractor
    extends BaseInteractor<List<dynamic>, List<Todo>> {
  GetCompletedTodosInteractor(this._repository);

  final TodoRepository _repository;

  @override
  Future<List<Todo>> call(List todoIds) {
    return _repository.getCompletedTodos(todoIds);
  }
}
