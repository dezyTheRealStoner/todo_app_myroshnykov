part of 'add_todo_cubit.dart';

@immutable
class AddTodoState extends Equatable {
  AddTodoState({
    this.title = '',
    this.description = '',
    this.todoType = 'default',
    DateTime? dateTime,
    this.allFieldsFilled = false,
    this.progress = false,
  }) : dateTime = dateTime ?? DateTime.now();

  final String title;
  final String description;
  final String todoType;
  final DateTime dateTime;

  final bool allFieldsFilled;
  final bool progress;

  AddTodoState copyWith({
    String? title,
    String? description,
    String? todoType,
    DateTime? dateTime,
    bool? allFieldsFilled,
    bool? progress,
  }) {
    return AddTodoState(
      title: title ?? this.title,
      description: description ?? this.description,
      todoType: todoType ?? this.todoType,
      dateTime: dateTime ?? this.dateTime,
      allFieldsFilled: allFieldsFilled ?? this.allFieldsFilled,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        todoType,
        dateTime,
        allFieldsFilled,
        progress,
      ];
}
