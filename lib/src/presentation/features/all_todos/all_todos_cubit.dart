import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/change_complete_status_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/get_all_user_todos_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/remove_todo_interactor.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

part 'all_todos_state.dart';

@injectable
class AllTodosCubit extends Cubit<AllTodosState> {
  AllTodosCubit(
    this._getAllUserTodosInteractor,
    this._changeCompleteStatusInteractor,
    this._removeTodoInteractor,
  ) : super(AllTodosState());

  final GetAllUserTodosInteractor _getAllUserTodosInteractor;
  final ChangeCompleteStatusInteractor _changeCompleteStatusInteractor;
  final RemoveTodoInteractor _removeTodoInteractor;

  final logger = getLogger('AllTodosCubit');

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

  void onDateSelected(DateTime selectedDate) {
    emit(state.copyWith(selectedDay: selectedDate));
  }

  Future<void> initData() async {
    try {
      emit(state.copyWith(updating: true));

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
    } finally {
      emit(state.copyWith(updating: false));
    }
  }

  Future<void> onChangeCompleteStatus(String id) async {
    try {
      await _changeCompleteStatusInteractor.call(id);

      await initData();
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  Future<void> onRemoveTodo(String id) async {
    try {
      await _removeTodoInteractor.call(id);

      await initData();
    } on Exception catch (error) {
      logger.e(error);
    }
  }
}
