import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';

Todo? getTodoFromBeamerState(BuildContext context) {
  final data = context.currentBeamLocation.data as Map<String, dynamic>;

  if (data['todo'] != null) {
    final serializedTodo = Map<String, dynamic>.from(data['todo'] as Map);

    return Todo.fromMap(serializedTodo);
  } else {
    return null;
  }
}
