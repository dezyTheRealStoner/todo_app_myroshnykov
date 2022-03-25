part of 'all_todos_cubit.dart';

@immutable
class AllTodosState extends Equatable {
  AllTodosState({
    this.updating = false,
    this.allTodosOpened = true,
    this.completedTodosOpened = false,
    this.uncompletedTodosOpened = false,
    this.allTodos = const [],
    this.completedTodos = const [],
    this.uncompletedTodos = const [],
    DateTime? selectedDay,
  }) : selectedDay = selectedDay ?? DateTime.now();

  final bool updating;

  final bool allTodosOpened;
  final bool completedTodosOpened;
  final bool uncompletedTodosOpened;

  final List<Todo> allTodos;
  final List<Todo> completedTodos;
  final List<Todo> uncompletedTodos;

  final DateTime selectedDay;

  AllTodosState copyWith({
    bool? updating,
    bool? allTodosOpened,
    bool? completedTodosOpened,
    bool? uncompletedTodosOpened,
    List<Todo>? allTodos,
    List<Todo>? completedTodos,
    List<Todo>? uncompletedTodos,
    DateTime? selectedDay,
  }) {
    return AllTodosState(
      updating: updating ?? this.updating,
      allTodosOpened: allTodosOpened ?? this.allTodosOpened,
      completedTodosOpened: completedTodosOpened ?? this.completedTodosOpened,
      uncompletedTodosOpened:
          uncompletedTodosOpened ?? this.uncompletedTodosOpened,
      allTodos: allTodos ?? this.allTodos,
      completedTodos: completedTodos ?? this.completedTodos,
      uncompletedTodos: uncompletedTodos ?? this.uncompletedTodos,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object?> get props => [
        updating,
        allTodosOpened,
        completedTodosOpened,
        uncompletedTodosOpened,
        allTodos,
        completedTodos,
        uncompletedTodos,
        selectedDay,
      ];
}