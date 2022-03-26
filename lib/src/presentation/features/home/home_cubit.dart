import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/change_complete_status_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/get_actual_todos_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/remove_todo_interactor.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getActualTodosInteractor,
    this._changeCompleteStatusInteractor,
    this._removeTodoInteractor,
  ) : super(const HomeState());

  final GetActualTodosInteractor _getActualTodosInteractor;
  final ChangeCompleteStatusInteractor _changeCompleteStatusInteractor;
  final RemoveTodoInteractor _removeTodoInteractor;

  final logger = getLogger('HomeCubit');

  Future<void> getAllUserTodos() async {
    try {
      emit(state.copyWith(updating: true));

      final todoList = await _getActualTodosInteractor.call();

      emit(state.copyWith(todoList: todoList));
    } on Exception catch (error) {
      logger.e(error);
    } finally {
      emit(state.copyWith(updating: false));
    }
  }

  Future<void> onChangeCompleteStatus(String id) async {
    try {
      await _changeCompleteStatusInteractor.call(id);

      await getAllUserTodos();
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  Future<void> onRemoveTodo(String id) async {
    try {
      await _removeTodoInteractor.call(id);

      await getAllUserTodos();
    } on Exception catch (error) {
      logger.e(error);
    }
  }
}
