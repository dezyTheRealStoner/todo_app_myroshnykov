part of 'all_todos_cubit.dart';

@immutable
class AllTodosState extends Equatable {
  AllTodosState({
    this.updating = false,
    this.allTodosOpened = false,
    this.completedTodosOpened = false,
    this.uncompletedTodosOpened = false,
    this.dateWasSelected = false,
    this.allTodos = const [],
    this.completedTodos = const [],
    this.uncompletedTodos = const [],
    DateTime? startDateTime,
    DateTime? selectedDay,
  })  : startDateTime = startDateTime ?? DateTime.now(),
        selectedDay = selectedDay ?? DateTime.now();

  final bool updating;

  final bool allTodosOpened;
  final bool completedTodosOpened;
  final bool uncompletedTodosOpened;
  final bool dateWasSelected;

  final List<Todo> allTodos;
  final List<Todo> completedTodos;
  final List<Todo> uncompletedTodos;

  final DateTime startDateTime;
  final DateTime selectedDay;

  AllTodosState copyWith({
    bool? updating,
    bool? allTodosOpened,
    bool? completedTodosOpened,
    bool? uncompletedTodosOpened,
    bool? dateWasSelected,
    List<Todo>? allTodos,
    List<Todo>? completedTodos,
    List<Todo>? uncompletedTodos,
    DateTime? startDateTime,
    DateTime? selectedDay,
  }) {
    return AllTodosState(
      updating: updating ?? this.updating,
      allTodosOpened: allTodosOpened ?? this.allTodosOpened,
      completedTodosOpened: completedTodosOpened ?? this.completedTodosOpened,
      uncompletedTodosOpened:
          uncompletedTodosOpened ?? this.uncompletedTodosOpened,
      dateWasSelected: dateWasSelected ?? this.dateWasSelected,
      allTodos: allTodos ?? this.allTodos,
      completedTodos: completedTodos ?? this.completedTodos,
      uncompletedTodos: uncompletedTodos ?? this.uncompletedTodos,
      startDateTime: startDateTime ?? this.startDateTime,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object?> get props => [
        updating,
        allTodosOpened,
        completedTodosOpened,
        uncompletedTodosOpened,
        dateWasSelected,
        allTodos,
        completedTodos,
        uncompletedTodos,
        startDateTime,
        selectedDay,
      ];
}
