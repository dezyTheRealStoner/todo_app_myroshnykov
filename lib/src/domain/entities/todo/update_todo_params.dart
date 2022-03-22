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
    String? updatedTitle,
    String? updatedDescription,
    String? updatedTodoType,
    DateTime? updateDateTime,
    bool? updatedCompleteStatus,
  ) {
    return UpdateTodoParams(
      id: id ?? this.id,
      title: updatedTitle ?? title,
      description: updatedDescription ?? description,
      todoType: updatedTodoType ?? todoType,
      dateTime: updateDateTime ?? dateTime,
      completed: updatedCompleteStatus ?? completed,
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
