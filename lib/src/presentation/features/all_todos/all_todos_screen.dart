import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/all_todos/all_todos_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/action_button_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/screen_title_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/todo_list_widget.dart';

class AllTodosScreen extends CubitWidget<AllTodosState, AllTodosCubit> {
  const AllTodosScreen({Key? key}) : super(key: key);

  static const screenName = '/all_todos';

  @override
  void initParams(BuildContext context) {
    cubit(context).initData();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarWidget(currentTabIndex: 1),
      body: SafeArea(
        child: Column(
          children: [
            ScreenTitleWidget(
              title: LocaleKeys.todos.tr(),
            ),
            _buildTopNavigationBar(context),
            const SizedBox(height: 30),
            _buildTodos(context),
            const SizedBox(height: 20),
            ActionButtonWidget(title: LocaleKeys.add_todo.tr()),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigationBar(
    BuildContext context,
  ) {
    return observeState(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTopNavigationBarItem(
              context: context,
              isSelected: state.allTodosOpened,
              title: LocaleKeys.all.tr(),
              onTap: () => cubit(context).onAllTodosOpened(),
            ),
            _buildTopNavigationBarItem(
              context: context,
              isSelected: state.completedTodosOpened,
              title: LocaleKeys.completed.tr(),
              onTap: () => cubit(context).onCompletedTodosOpened(),
            ),
            _buildTopNavigationBarItem(
              context: context,
              isSelected: state.uncompletedTodosOpened,
              title: LocaleKeys.uncompleted.tr(),
              onTap: () => cubit(context).onUncompletedTodosOpened(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigationBarItem({
    required BuildContext context,
    required bool isSelected,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: theme.textTheme.bodyText2!.copyWith(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTodos(BuildContext context) {
    return observeState(builder: (context, state) {
      if (state.allTodosOpened) {
        return const SizedBox();
      } else if (state.completedTodosOpened) {
        return TodoListWidget(
          updating: state.updating,
          listLength: state.completedTodos.length,
          todoList: state.completedTodos,
          onRemoveConfirm: (index) {},
        );
      } else if (state.uncompletedTodosOpened) {
        return TodoListWidget(
          updating: state.updating,
          listLength: state.uncompletedTodos.length,
          todoList: state.uncompletedTodos,
          onRemoveConfirm: (index) {},
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
