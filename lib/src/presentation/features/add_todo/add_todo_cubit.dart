import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/add_todo_params.dart';
import 'package:todo_app_myroshnykov/src/domain/interactors/todo/add_todo_interactor.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/logger/custom_logger.dart';

part 'add_todo_state.dart';

@injectable
class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(
    this._addTodoInteractor,
  ) : super(AddTodoState());

  final AddTodoInteractor _addTodoInteractor;

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

    logger.i(state.dateTime);
  }

  Future<void> onTodoAdded() async {
    final addTodoParams = AddTodoParams(
      title: state.title,
      description: state.description,
      todoType: state.todoType,
      dateTime: state.dateTime,
    );

    try {
      emit(state.copyWith(progress: true));

      await _addTodoInteractor.call(addTodoParams);
    } on Exception catch (error) {
      logger.e(error);
    } finally {
      emit(state.copyWith(progress: false));
    }
  }
}
