part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.todoList = const [],
  });

  final List<Todo> todoList;

  HomeState copyWith({
    List<Todo>? todoList,
  }) {
    return HomeState(
      todoList: todoList ?? this.todoList,
    );
  }

  @override
  List<Object?> get props => [
        todoList,
      ];
}
