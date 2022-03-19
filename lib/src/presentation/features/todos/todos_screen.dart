import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todos/todos_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';

class TodosScreen extends CubitWidget<TodosState, TodosCubit> {
  const TodosScreen({Key? key}) : super(key: key);

  static const screenName = '/todos';

  @override
  Widget buildWidget(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(currentTabIndex: 1),
      body: Center(
        child: Text('Todos'),
      ),
    );
  }
}
