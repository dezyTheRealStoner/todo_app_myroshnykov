import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/all_todo_screen_state_params.dart';

Todo? getTodoFromBeamer(BuildContext context) {
  if (context.currentBeamLocation.data != null) {
    final data = context.currentBeamLocation.data as Map<String, dynamic>;

    if (data['todo'] != null) {
      final serializedTodo = Map<String, dynamic>.from(data['todo'] as Map);

      return Todo.fromMap(serializedTodo);
    } else {
      return null;
    }
  } else {
    return null;
  }
}

AllTodoScreenStateParams? getAllTodoScreenStateParamsFromBeamer(
    BuildContext context) {
  if (context.currentBeamLocation.data != null) {
    final data = context.currentBeamLocation.data as Map<String, dynamic>;

    if (data['allTodoScreenStateParams'] != null) {
      final serializedScreenStateParams =
          Map<String, dynamic>.from(data['allTodoScreenStateParams'] as Map);

      return AllTodoScreenStateParams.fromMap(serializedScreenStateParams);
    } else {
      return null;
    }
  } else {
    return null;
  }
}
