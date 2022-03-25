import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/get_all_user_todos_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/user/get_user_info_interactor.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

part 'all_todos_state.dart';

@injectable
class AllTodosCubit extends Cubit<AllTodosState> {
  AllTodosCubit(
    this._getAllUserTodosInteractor,
  ) : super(const AllTodosState());

  final GetAllUserTodosInteractor _getAllUserTodosInteractor;

  final logger = getLogger('AllTodosCubit');

  Future<void> initData() async {
    try {
      final allTodos = await _getAllUserTodosInteractor.call();

      List<Todo> completedTodos = [];
      List<Todo> uncompletedTodos = [];

      for (var todo in allTodos) {
        todo.completed ? completedTodos.add(todo) : uncompletedTodos.add(todo);
      }

      completedTodos.sort(
        (a, b) => b.dateTime.compareTo(a.dateTime),
      );

      emit(state.copyWith(
        allTodos: allTodos,
        completedTodos: completedTodos,
        uncompletedTodos: uncompletedTodos,
      ));
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  void onAllTodosOpened() {
    emit(state.copyWith(
      allTodosOpened: true,
      completedTodosOpened: false,
      uncompletedTodosOpened: false,
    ));
  }

  void onCompletedTodosOpened() {
    emit(state.copyWith(
      allTodosOpened: false,
      completedTodosOpened: true,
      uncompletedTodosOpened: false,
    ));
  }

  void onUncompletedTodosOpened() {
    emit(state.copyWith(
      allTodosOpened: false,
      completedTodosOpened: false,
      uncompletedTodosOpened: true,
    ));
  }
}
