import 'package:todo_app_myroshnykov/src/domain/entities/todo/add_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/update_todo_params.dart';

abstract class TodoRepository {
  Future<void> addTodo(AddTodoParams params);

  Future<void> removeTodo(String id);

  Future<void> changeCompleteStatus(String id);

  Future<void> updateTodo(UpdateTodoParams params);

  Future<Todo> getTodo(String id);

  Future<List<Todo>> getAllUserTodos();

  Future<List<Todo>> getActualTodos();
}
