import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo({
    required this.title,
    required this.description,
    required this.todoType,
    required this.dateTime,
    required this.completed,
  });

  final String title;
  final String description;
  final String todoType;
  final DateTime dateTime;
  final bool completed;

  Todo copyWith(
    String? title,
    String? description,
    String? todoType,
    DateTime? dateTime,
    bool? completed,
  ) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      todoType: todoType ?? this.todoType,
      dateTime: dateTime ?? this.dateTime,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        todoType,
        dateTime,
        completed,
      ];
}
