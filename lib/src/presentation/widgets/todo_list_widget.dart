import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/dialogs/two_action_dialog.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/todo_card_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({
    Key? key,
    required this.updating,
    required this.listLength,
    required this.todoList,
    required this.onRemoveConfirm,
  }) : super(key: key);

  final bool updating;
  final int listLength;
  final List<Todo> todoList;
  final Function(int) onRemoveConfirm;

  Future<void> removeTodo() async {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1),
        ),
        child: updating
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: listLength,
                itemBuilder: (context, index) => TodoCardWidget(
                  todo: todoList.elementAt(index),
                  onRemove: () => showTwoActionDialog(
                    context: context,
                    title: LocaleKeys.sure_want_delete.tr(),
                    onConfirm: () {
                      onRemoveConfirm(index);
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
