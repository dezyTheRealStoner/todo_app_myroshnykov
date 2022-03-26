import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/num_to_month.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/hold_progress_button_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/icon_button_widget.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({
    Key? key,
    required this.todo,
    required this.onChangeCompleteStatus,
    required this.onRemove,
  }) : super(key: key);

  final Todo todo;
  final VoidCallback onChangeCompleteStatus;
  final VoidCallback onRemove;

  void _navigateToTodoScreen(BuildContext context) {
    Beamer.of(context).beamToNamed(
      TodoScreen.screenName,
      data: <String, dynamic>{
        'todo': todo.toMap(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => _navigateToTodoScreen(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        todo.title,
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        todo.description,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _navigateToTodoScreen(context),
                    child: Column(
                      children: [
                        Text(
                            '${todo.dateTime.day} ${numToMonth(todo.dateTime.month)} ${todo.dateTime.year}'),
                        const SizedBox(height: 10),
                        Text(DateFormat.Hm().format(todo.dateTime)),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 20),
                      HoldProgressButtonWidget(
                        onChangeCompleteStatus: () => onChangeCompleteStatus(),
                        completed: todo.completed,
                      ),
                      IconButtonWidget(
                        icon: Icons.delete_forever,
                        color: Colors.red,
                        onTap: onRemove,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
