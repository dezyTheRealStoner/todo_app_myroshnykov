import 'package:equatable/equatable.dart';

class UpdateTodoParams extends Equatable {
  const UpdateTodoParams({
    required this.id,
    required this.title,
    required this.description,
    required this.todoType,
    required this.dateTime,
    required this.completed,
  });

  final String id;
  final String title;
  final String description;
  final String todoType;
  final DateTime dateTime;
  final bool completed;

  UpdateTodoParams copyWith(
    String? id,
    String? title,
    String? description,
    String? todoType,
    DateTime? dateTime,
    bool? completed,
  ) {
    return UpdateTodoParams(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      todoType: todoType ?? this.todoType,
      dateTime: dateTime ?? this.dateTime,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        todoType,
        dateTime,
        completed,
      ];
}
