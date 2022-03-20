import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.disabled,
    required this.progress,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final bool disabled;
  final bool progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      width: 120,
      child: ElevatedButton(
        onPressed: progress || disabled ? null : () => onPressed(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            disabled
                ? theme.colorScheme.onSecondary
                : theme.colorScheme.primary,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        child: Center(
          child: progress
              ? SizedBox(
                  height: 20,
                  child: CircularProgressIndicator(
                      color: theme.colorScheme.onPrimary),
                )
              : Text(
                  title,
                  style: theme.textTheme.subtitle1?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}
