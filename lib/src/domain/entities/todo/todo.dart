import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo({
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

  Todo copyWith(
    String? id,
    String? title,
    String? description,
    String? todoType,
    DateTime? dateTime,
    bool? completed,
  ) {
    return Todo(
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'todoType': todoType,
      'dateTime': dateTime,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      todoType: map['todoType'] as String,
      dateTime: map['dateTime'] as DateTime,
      completed: map['completed'] as bool,
    );
  }
}
