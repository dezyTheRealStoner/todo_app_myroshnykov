import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/profile_data_source.dart';
import 'package:todo_app_myroshnykov/src/data/firebase/todo_data_source.dart';
import 'package:todo_app_myroshnykov/src/data/mappers/todo_mapper.dart';
import 'package:todo_app_myroshnykov/src/data/mappers/user_mapper.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/add_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/update_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/todo_repository.dart';
import 'package:todo_app_myroshnykov/src/domain/repositories/user_repository.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(
    this._todoDataSource,
    this._profileDataSource,
    this._userRepository,
  );

  final TodoDataSource _todoDataSource;
  final ProfileDataSource _profileDataSource;
  final UserRepository _userRepository;

  final logger = getLogger('TodoRepositoryImpl');

  @override
  Future<void> addTodo(AddTodoParams params) async {
    final newTodoId = _getRandomString();

    try {
      await _todoDataSource.updateTodoData(
        todoId: newTodoId,
        title: params.title,
        description: params.description,
        todoType: params.todoType,
        dateTime: params.dateTime,
        completed: false,
      );

      final userSnapshot = await _profileDataSource.getUserProfileData();

      final user = UserMapper().fromDocument(userSnapshot);

      await _profileDataSource.updateProfileData(
        email: user.email,
        name: user.name,
        image: user.image,
        completedTodos: user.completedTodos,
        todoIds: user.todoIds..add(newTodoId),
        theme: themeToString(user.theme),
        language: languageToString(user.language),
      );
    } on Exception catch (error) {
      logger.e('$error, hashCode: ${error.hashCode}');
      throw Exception();
    }
  }

  @override
  Future<void> removeTodo(String id) async {
    try {
      final user = await _userRepository.getUserInfo();

      user.todoIds.remove(id);

      await _profileDataSource.updateProfileData(
        email: user.email,
        name: user.name,
        image: user.image,
        todoIds: user.todoIds,
        completedTodos: user.completedTodos,
        theme: themeToString(user.theme),
        language: languageToString(user.language),
      );

      await _todoDataSource.removeTodo(id: id);
    } on Exception catch (error) {
      logger.e('$error, hashCode: ${error.hashCode}');
      throw Exception();
    }
  }

  @override
  Future<void> updateTodo(UpdateTodoParams params) async {
    try {
      await _todoDataSource.updateTodoData(
        todoId: params.id,
        title: params.title,
        description: params.description,
        todoType: params.todoType,
        dateTime: params.dateTime,
        completed: params.completed,
      );
    } on Exception catch (error) {
      logger.e('$error, hashCode: ${error.hashCode}');
      throw Exception();
    }
  }

  @override
  Future<Todo> getTodo(String id) async {
    try {
      final todoSnapshot = await _todoDataSource.getTodo(todoId: id);

      final todo = TodoMapper().fromDocument(todoSnapshot);

      return todo;
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }

  @override
  Future<List<Todo>> getAllUserTodos() async {
    try {
      final user = await _userRepository.getUserInfo();

      List<Todo> todoList = [];

      for (var todoId in user.todoIds) {
        final todoSnapshot = await _todoDataSource.getTodo(
          todoId: todoId,
        );

        final todo = TodoMapper().fromDocument(todoSnapshot);

        todoList.add(todo);
      }

      todoList.sort((a, b) {
        return a.dateTime.compareTo(b.dateTime);
      });

      return todoList;
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }

  @override
  Future<List<Todo>> getActualTodos() async {
    try {
      final user = await _userRepository.getUserInfo();

      List<Todo> actualTodoList = [];

      for (var todoId in user.todoIds) {
        final todoSnapshot = await _todoDataSource.getTodo(
          todoId: todoId,
        );

        final todo = TodoMapper().fromDocument(todoSnapshot);

        actualTodoList.add(todo);
      }
      return actualTodoList;
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
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
