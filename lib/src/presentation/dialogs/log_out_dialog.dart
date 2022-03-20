import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/icon_button_widget.dart';

Future<void> showLogOutDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        LocaleKeys.sure_about_log_out.tr(),
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
