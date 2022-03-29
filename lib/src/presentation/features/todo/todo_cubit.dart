import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/add_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/update_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/add_todo_interactor.dart';
import 'package:todo_app_myroshnykov/src//logger/custom_logger.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/remove_todo_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/update_todo_interactor.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/all_todo_screen_state_params.dart';

part 'todo_state.dart';

@injectable
class TodoCubit extends Cubit<TodoState> {
  TodoCubit(
    this._addTodoInteractor,
    this._updateTodoInteractor,
    this._removeTodoInteractor,
  ) : super(TodoState());

  final AddTodoInteractor _addTodoInteractor;
  final UpdateTodoInteractor _updateTodoInteractor;
  final RemoveTodoInteractor _removeTodoInteractor;

  final logger = getLogger('AddTodoCubit');

  void checkAllFieldFilled() {
    emit(
      state.copyWith(
        allFieldsFilled: state.title.isNotEmpty && state.description.isNotEmpty,
      ),
    );
  }

  void onTitleChanged(String title) {
    emit(state.copyWith(title: title));
    checkAllFieldFilled();
  }

  void onDescriptionChanged(String description) {
    emit(state.copyWith(description: description));
    checkAllFieldFilled();
  }

  void onDateSelect(DateTime dateTime) {
    emit(state.copyWith(dateTime: dateTime));

    checkAllFieldFilled();
  }

  void onCompleteTapped() {
    state.completed
        ? emit(state.copyWith(completed: false))
        : emit(state.copyWith(completed: true));

    checkAllFieldFilled();
  }

  void setBackParams(AllTodoScreenStateParams params) {
    if (params.allTodoScreenStateToBack == AllTodoScreenStateToBack.all) {
      emit(state.copyWith(backTodAllTodos: true));
    } else if (params.allTodoScreenStateToBack ==
        AllTodoScreenStateToBack.completed) {
      emit(state.copyWith(backToCompletedTodos: true));
    } else if (params.allTodoScreenStateToBack ==
        AllTodoScreenStateToBack.uncompleted) {
      emit(state.copyWith(backToUncompletedTodos: true));
    }
  }

  Future<void> initDataForUpdate(Todo todo) async {
    emit(state.copyWith(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      dateTime: todo.dateTime,
      completed: todo.completed,
      todoInfoUpdating: true,
    ));
  }

  Future<void> onDelete() async {
    try {
      await _removeTodoInteractor.call(state.id);
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  Future<void> onSubmit() async {
    final updateTodoParams = UpdateTodoParams(
      id: state.id,
      title: state.title,
      description: state.description,
      todoType: state.todoType,
      dateTime: state.dateTime,
      completed: state.completed,
    );

    final addTodoParams = AddTodoParams(
      title: state.title,
      description: state.description,
      todoType: state.todoType,
      dateTime: state.dateTime,
    );

    try {
      emit(state.copyWith(progress: true));

      if (state.todoInfoUpdating) {
        await _updateTodoInteractor.call(updateTodoParams);
      } else {
        await _addTodoInteractor.call(addTodoParams);
      }
    } on Exception catch (error) {
      logger.e(error);
    } finally {
      emit(state.copyWith(progress: false));
    }
  }
}
