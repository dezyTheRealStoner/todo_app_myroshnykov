import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'all_todos_state.dart';

@injectable
class AllTodosCubit extends Cubit<AllTodosState> {
  AllTodosCubit() : super(AllTodosState());
}
