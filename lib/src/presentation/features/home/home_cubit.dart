import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/get_all_user_todos_interactor.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/user/get_user_info_interactor.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getAllUserTodosInteractor,
    this._getUserInfoInteractor,
  ) : super(const HomeState());

  final GetAllUserTodosInteractor _getAllUserTodosInteractor;
  final GetUserInfoInteractor _getUserInfoInteractor;

  final logger = getLogger('HomeCubit');

  Future<void> getAllUserTodos() async {
    try {
      emit(state.copyWith(updating: true));

      final updatedUser = await _getUserInfoInteractor();

      final todoList =
          await _getAllUserTodosInteractor.call(updatedUser.todoIds);

      List<Todo> actualTodoList = [];

      for (var todo in todoList) {
        if (todo.dateTime.isAfter(DateTime.now())) {
          actualTodoList.add(todo);
        }
      }

      emit(state.copyWith(todoList: actualTodoList));
    } on Exception catch (error) {
      logger.e(error);
    } finally {
      emit(state.copyWith(updating: false));
    }
  }
}
