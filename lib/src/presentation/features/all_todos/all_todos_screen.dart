import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/todo/todo.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_state.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/all_todos/all_todos_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/all_todo_screen_state_params.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/beamer_state_utils.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/action_button_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/screen_title_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/todo_list_widget.dart';

class AllTodosScreen extends StatefulWidget {
  const AllTodosScreen({Key? key}) : super(key: key);

  static const screenName = '/all_todos';

  @override
  State<AllTodosScreen> createState() => _AllTodosScreenState();
}

class _AllTodosScreenState
    extends CubitState<AllTodosScreen, AllTodosState, AllTodosCubit> {
  bool hasDateTodo({
    required DateTime date,
    required AllTodosState state,
  }) {
    bool hasDateTodo = false;

    for (var todo in state.allTodos) {
      if (todo.dateTime.year == date.year &&
          todo.dateTime.month == date.month &&
          todo.dateTime.day == date.day) {
        hasDateTodo = true;
      }
    }
    return hasDateTodo;
  }

  List<Todo> getTodosForSelectedDay({required AllTodosState state}) {
    return state.dateWasSelected
        ? state.allTodos
            .where((todo) =>
                todo.dateTime.year == state.selectedDay.year &&
                todo.dateTime.month == state.selectedDay.month &&
                todo.dateTime.day == state.selectedDay.day)
            .toList()
        : state.allTodos
            .where((todo) =>
                todo.dateTime.year == state.startDateTime.year &&
                todo.dateTime.month == state.startDateTime.month &&
                todo.dateTime.day == state.startDateTime.day)
            .toList();
  }

  void _navigateToTodoScreen({
    required BuildContext context,
    required List<Todo> todoList,
    required int index,
  }) {
    AllTodoScreenStateToBack allTodoScreenState() {
      if (cubit(context).state.allTodosOpened) {
        return AllTodoScreenStateToBack.all;
      } else if (cubit(context).state.completedTodosOpened) {
        return AllTodoScreenStateToBack.completed;
      } else {
        return AllTodoScreenStateToBack.uncompleted;
      }
    }

    final allTodoScreenStateParams = AllTodoScreenStateParams(
      allTodoScreenStateToBack: allTodoScreenState(),
      dateTime: cubit(context).state.selectedDay,
    );

    logger.i(allTodoScreenStateParams);

    Beamer.of(context).beamToNamed(
      TodoScreen.screenName,
      data: <String, dynamic>{
        'todo': todoList.elementAt(index).toMap(),
        'allTodoScreenStateParams': allTodoScreenStateParams.toMap(),
      },
    );
  }

  @override
  void initParams(BuildContext context) {
    cubit(context).initData();

    if (getAllTodoScreenStateParamsFromBeamer(context) != null) {
      logger.i('hi');

      final allTodoScreenStateParams =
          getAllTodoScreenStateParamsFromBeamer(context);
      if (allTodoScreenStateParams!.allTodoScreenStateToBack ==
          AllTodoScreenStateToBack.all) {
        cubit(context).onAllTodosOpened();
        cubit(context).setStartDateTime(allTodoScreenStateParams.dateTime);
      } else if (allTodoScreenStateParams.allTodoScreenStateToBack ==
              AllTodoScreenStateToBack.completed &&
          !cubit(context).state.allTodosOpened) {
        cubit(context).onCompletedTodosOpened();
      } else if (allTodoScreenStateParams.allTodoScreenStateToBack ==
              AllTodoScreenStateToBack.uncompleted &&
          !cubit(context).state.allTodosOpened) {
        cubit(context).onUncompletedTodosOpened();
      }
    } else {
      cubit(context).onAllTodosOpened();
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const BottomNavigationBarWidget(currentTabIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ScreenTitleWidget(
                title: LocaleKeys.todos.tr(),
              ),
              _buildTopNavigationBar(context),
              const SizedBox(height: 20),
              _buildTodos(context),
              const SizedBox(height: 20),
              ActionButtonWidget(title: LocaleKeys.add_todo.tr()),
              const SizedBox(height: 20),
            ],
          ),
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
              isSelected: state.uncompletedTodosOpened,
              title: LocaleKeys.uncompleted.tr(),
              onTap: () => cubit(context).onUncompletedTodosOpened(),
            ),
            _buildTopNavigationBarItem(
              context: context,
              isSelected: state.completedTodosOpened,
              title: LocaleKeys.completed.tr(),
              onTap: () => cubit(context).onCompletedTodosOpened(),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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

  final logger = getLogger('alltodos');

  Widget _buildTodos(BuildContext context) {
    return observeState(builder: (context, state) {
      if (state.allTodosOpened) {
        return Column(
          children: [
            _buildCalendar(context, state),
            _buildCalendarTodoList(
              context: context,
              todoList: getTodosForSelectedDay(state: state),
              state: state,
            ),
          ],
        );
      } else if (state.completedTodosOpened) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: TodoListWidget(
              updating: state.updating,
              listLength: state.completedTodos.length,
              todoList: state.completedTodos,
              navigateToTodoScreen: (index) => _navigateToTodoScreen(
                    context: context,
                    todoList: state.completedTodos,
                    index: index,
                  ),
              onChangeCompleteStatus: (index) => cubit(context)
                  .onChangeCompleteStatus(
                      state.completedTodos.elementAt(index).id),
              onRemoveConfirm: (index) async {
                await cubit(context)
                    .onRemoveTodo(state.completedTodos.elementAt(index).id);
                Navigator.pop(context);
              }),
        );
      } else if (state.uncompletedTodosOpened) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: TodoListWidget(
              updating: state.updating,
              listLength: state.uncompletedTodos.length,
              todoList: state.uncompletedTodos,
              navigateToTodoScreen: (index) => _navigateToTodoScreen(
                    context: context,
                    todoList: state.completedTodos,
                    index: index,
                  ),
              onChangeCompleteStatus: (index) =>
                  cubit(context).onChangeCompleteStatus(
                    state.uncompletedTodos.elementAt(index).id,
                  ),
              onRemoveConfirm: (index) async {
                await cubit(context)
                    .onRemoveTodo(state.uncompletedTodos.elementAt(index).id);
                Navigator.pop(context);
              }),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _buildCalendar(
    BuildContext context,
    AllTodosState state,
  ) {
    return TableCalendar(
      currentDay: DateTime.now(),
      focusedDay: state.selectedDay,
      firstDay: DateTime(2020, 01, 01),
      lastDay: DateTime(2026, 12, 31),
      daysOfWeekHeight: 25,
      locale: context.locale.languageCode,
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (DateTime date) {
        return state.dateWasSelected
            ? isSameDay(state.selectedDay, date)
            : isSameDay(state.startDateTime, date);
      },
      onDaySelected: (DateTime selectDay, DateTime focusDay) {
        cubit(context).onDateSelected(selectDay);
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).colorScheme.primary,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, date) {
          return Center(
            child: Text(
              DateFormat.yMMM().format(date),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        },
        defaultBuilder: (context, date, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 5),
                hasDateTodo(date: date, state: state)
                    ? _dateHasTodoDot()
                    : _dateHasNotTodoDot()
              ],
            ),
          );
        },
        selectedBuilder: (context, date, _) {
          return Center(
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  hasDateTodo(date: date, state: state)
                      ? _dateHasTodoDot()
                      : _dateHasNotTodoDot()
                ],
              ),
            ),
          );
        },
        todayBuilder: (context, date, _) {
          return Center(
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  hasDateTodo(date: date, state: state)
                      ? _dateHasTodoDot()
                      : _dateHasNotTodoDot()
                ],
              ),
            ),
          );
        },
        outsideBuilder: (context, date, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _dateHasTodoDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  Widget _dateHasNotTodoDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildCalendarTodoList({
    required BuildContext context,
    required List<Todo> todoList,
    required AllTodosState state,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          DateFormat.yMMMd().format(
            state.dateWasSelected ? state.selectedDay : state.startDateTime,
          ),
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        AnimatedCrossFade(
          crossFadeState: todoList.isEmpty
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 600),
          firstChild: SizedBox(width: MediaQuery.of(context).size.width),
          secondChild: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            shrinkWrap: true,
            itemCount: todoList.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _navigateToTodoScreen(
                      context: context,
                      todoList: todoList,
                      index: index,
                    ),
                    child: Text(
                      todoList.elementAt(index).title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToTodoScreen(
                      context: context,
                      todoList: todoList,
                      index: index,
                    ),
                    child: Text(
                      DateFormat.Hm()
                          .format(todoList.elementAt(index).dateTime),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
