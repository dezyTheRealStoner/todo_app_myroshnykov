import 'package:equatable/equatable.dart';

class AddTodoParams extends Equatable {
  const AddTodoParams({
    required this.title,
    required this.description,
    required this.todoType,
    required this.dateTime,
  });

  final String title;
  final String description;
  final String todoType;
  final DateTime dateTime;

  AddTodoParams copyWith(
    String? title,
    String? description,
    String? todoType,
    DateTime? dateTime,
  ) {
    return AddTodoParams(
      title: title ?? this.title,
      description: description ?? this.description,
      todoType: todoType ?? this.todoType,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        todoType,
        dateTime,
      ];
}
