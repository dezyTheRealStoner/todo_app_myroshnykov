import 'package:flutter/material.dart';

SnackBar snackBar({
  required String label,
  required BuildContext context,
  int? duration,
}) {
  return SnackBar(
    duration: Duration(milliseconds: duration ?? 2000),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Theme.of(context).colorScheme.secondary,
  );
}
