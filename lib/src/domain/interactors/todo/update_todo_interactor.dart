import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/update_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/base/base_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/todo_repository.dart';

@LazySingleton()
class UpdateTodoInteractor extends BaseInteractor<UpdateTodoParams, void> {
  UpdateTodoInteractor(this._repository);

  final TodoRepository _repository;

  @override
  Future<void> call(UpdateTodoParams params) {
    return _repository.updateTodo(params);
  }
}
