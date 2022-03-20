import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/auth_data_source.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/profile_data_source.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/todo_data_source.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/add_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/update_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/todo_repository.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._authDataSource);

  final AuthDataSource _authDataSource;

  final logger = getLogger('TodoRepositoryImpl');

  @override
  Future<void> addTodo(AddTodoParams params) async {
    final newTodoId = _getRandomString();

    final todoDataSource = TodoDataSource(id: newTodoId);

    try {
      todoDataSource.updateTodoData(
        title: params.title,
        description: params.description,
        todoType: params.todoType,
        dateTime: params.dateTime,
        completed: false,
      );

      final user = await _authDataSource.getUserInfo();

      List<dynamic> updatedTodoIds = user.todoIds..add(newTodoId);

      ProfileDataSource(id: user.email).updateProfileData(
        email: user.email,
        name: user.name,
        image: user.image,
        todoIds: updatedTodoIds,
      );
    } on Exception catch (error) {
      logger.e('$error, hashCode: ${error.hashCode}');
      throw Exception();
    }
  }

  @override
  Future<void> changeTodoCompleteStatus(String id) {
    // TODO: implement changeTodoCompleteStatus
    throw UnimplementedError();
  }

  @override
  Future<void> removeTodo(String id) {
    // TODO: implement removeTodo
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(UpdateTodoParams params) async {
    final todoDataSource = TodoDataSource(id: params.id);

    try {
      todoDataSource.updateTodoData(
        title: params.updatedTitle,
        description: params.updatedDescription,
        todoType: params.updatedTodoType,
        dateTime: params.updateDateTime,
        completed: params.updatedCompleteStatus,
      );
    } on Exception catch (error) {
      logger.e('$error, hashCode: ${error.hashCode}');
      throw Exception();
    }
  }

  @override
  Future<Todo> getTodo(String id) {
    // TODO: implement getTodo
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> getAllUserTodos(String userId) {
    // TODO: implement getAllUserTodos
    throw UnimplementedError();
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final _rnd = Random();

  static String _getRandomString() {
    return String.fromCharCodes(
      Iterable.generate(
        20,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
  }
}
