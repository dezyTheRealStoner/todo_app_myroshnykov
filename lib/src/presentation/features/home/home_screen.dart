import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/action_button_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/screen_title_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/todo_list_widget.dart';

class HomeScreen extends CubitWidget<HomeState, HomeCubit> {
  const HomeScreen({Key? key}) : super(key: key);

  static const screenName = '/home';

  @override
  void initParams(BuildContext context) {
    cubit(context).getAllUserTodos();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarWidget(currentTabIndex: 0),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ScreenTitleWidget(
              title: LocaleKeys.your_coming_todos.tr(),
            ),
            const SizedBox(height: 20),
            _buildList(context),
            const SizedBox(height: 20),
            ActionButtonWidget(title: LocaleKeys.add_todo.tr()),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return observeState(
      builder: (context, state) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: TodoListWidget(
          updating: state.updating,
          listLength: state.todoList.length,
          todoList: state.todoList,
          navigateToTodoScreen: (index) =>
              Beamer.of(context).beamToNamed(TodoScreen.screenName, data: {
            'todo': state.todoList.elementAt(index).toMap(),
          }),
          onChangeCompleteStatus: (index) => cubit(context)
              .onChangeCompleteStatus(state.todoList.elementAt(index).id),
          onRemoveConfirm: (index) async {
            await cubit(context)
                .onRemoveTodo(state.todoList.elementAt(index).id);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
