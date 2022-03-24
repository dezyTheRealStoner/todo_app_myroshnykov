import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/all_todos/all_todos_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';

class AllTodosScreen extends CubitWidget<AllTodosState, AllTodosCubit> {
  const AllTodosScreen({Key? key}) : super(key: key);

  static const screenName = '/all_todos';

  @override
  Widget buildWidget(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(currentTabIndex: 1),
      body: Center(
        child: Text('All Todos'),
      ),
    );
  }
}
