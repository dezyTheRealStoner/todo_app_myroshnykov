import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_screen.dart';

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      onPressed: () => Beamer.of(context).beamToNamed(TodoScreen.screenName),
      child: Text(
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.background),
      ),
    );
  }
}
