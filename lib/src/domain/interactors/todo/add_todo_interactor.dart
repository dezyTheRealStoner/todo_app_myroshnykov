import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/add_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/todo_repository.dart';

@LazySingleton()
class AddTodoInteractor extends BaseInteractor<AddTodoParams, void> {
  AddTodoInteractor(this._repository);

  final TodoRepository _repository;

  @override
  Future<void> call(AddTodoParams params) {
    return _repository.addTodo(params);
  }
}
