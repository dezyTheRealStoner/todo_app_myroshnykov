import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/icon_button_widget.dart';

Future<void> showTwoActionDialog({
  required BuildContext context,
  required String title,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButtonWidget(
              color: Theme.of(context).colorScheme.primary,
              icon: Icons.close,
              onTap: () => Navigator.pop(context),
            ),
            IconButtonWidget(
              color: Theme.of(context).colorScheme.primary,
              icon: Icons.check,
              onTap: onConfirm,
            ),
          ],
        )
      ],
    ),
  );
}
