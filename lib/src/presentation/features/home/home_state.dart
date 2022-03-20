part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.todoList = const [],
    this.updating = false,
  });

  final List<Todo> todoList;
  final bool updating;

  HomeState copyWith({
    List<Todo>? todoList,
    bool? updating,
  }) {
    return HomeState(
      todoList: todoList ?? this.todoList,
      updating: updating ?? this.updating,
    );
  }

  @override
  List<Object?> get props => [
        todoList,
        updating,
      ];
}
