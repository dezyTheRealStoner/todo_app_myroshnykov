import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'todos_state.dart';

@injectable
class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(TodosState());
}
