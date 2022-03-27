import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app_myroshnykov/src/logger/custom_logger.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_state.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/dialogs/two_action_dialog.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/all_todo_screen_state_params.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/beamer_state_utils.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/num_to_month.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/icon_button_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/outlined_input_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/snack_bar.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/submit_button_widget.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  static const screenName = '/addTodo';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends CubitState<TodoScreen, TodoState, TodoCubit> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final logger = getLogger('todo screen');

  @override
  void initParams(BuildContext context) {
    if (getTodoFromBeamer(context) != null) {
      final todo = getTodoFromBeamer(context);
      cubit(context).initDataForUpdate(todo!);
    }

    if (getAllTodoScreenStateParamsFromBeamer(context) != null) {
      final allTodoScreenStateParams =
          getAllTodoScreenStateParamsFromBeamer(context);
      cubit(context).setBackParams(allTodoScreenStateParams!);
    }

    final state = cubit(context).state;

    _titleController
      ..text = state.title
      ..addListener(
        () => cubit(context).onTitleChanged(_titleController.text),
      );

    _descriptionController
      ..text = state.description
      ..addListener(
        () => cubit(context).onDescriptionChanged(_descriptionController.text),
      );
  }

  void _navigateBack() {
    if (cubit(context).state.backTodAllTodos ||
        cubit(context).state.backToCompletedTodos ||
        cubit(context).state.backToUncompletedTodos) {
      AllTodoScreenStateToBack allTodoScreenStateToBack() {
        if (cubit(context).state.backTodAllTodos) {
          logger.i('all');
          return AllTodoScreenStateToBack.all;
        } else if (cubit(context).state.backToCompletedTodos) {
          logger.i('completed');
          return AllTodoScreenStateToBack.completed;
        } else {
          return AllTodoScreenStateToBack.uncompleted;
        }
      }

      final allTodoScreenStateParams = AllTodoScreenStateParams(
        allTodoScreenStateToBack: allTodoScreenStateToBack(),
        dateTime: cubit(context).state.dateTime,
      );

      logger.i('hi');

      Beamer.of(context).beamBack(data: <String, dynamic>{
        'allTodoScreenStateParams': allTodoScreenStateParams.toMap(),
      });
    } else {
      Beamer.of(context).beamBack(data: <String, dynamic>{});
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return observeState(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: state.todoInfoUpdating
              ? Text(LocaleKeys.update_todo.tr().toUpperCase())
              : Text(LocaleKeys.add_todo.tr().toUpperCase()),
          leading: BackButton(
            onPressed: () => _navigateBack(),
          ),
        ),
        body: SingleChildScrollView(
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: observeState(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            _buildInputWidgets(),
            const SizedBox(height: 10),
            _buildDateText(state),
            const SizedBox(height: 10),
            _buildDatePickerButton(
              context: context,
              state: state,
            ),
            const SizedBox(height: 20),
            state.todoInfoUpdating
                ? _buildActionIcons(state)
                : const SizedBox(),
            const SizedBox(height: 50),
            SubmitButtonWidget(
              title: LocaleKeys.submit.tr(),
              onPressed: () async {
                await cubit(context).onSubmit();
                _navigateBack();
              },
              disabled: !state.allFieldsFilled,
              progress: state.progress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputWidgets() {
    return Column(
      children: [
        OutlinedInputWidget(
          controller: _titleController,
          maxLength: 30,
          hintText: LocaleKeys.title.tr(),
        ),
        const SizedBox(height: 10),
        OutlinedInputWidget(
          controller: _descriptionController,
          maxLength: 300,
          maxLines: 9,
          hintText: LocaleKeys.description.tr(),
        ),
      ],
    );
  }

  Widget _buildActionIcons(TodoState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.completed
              ? IconButtonWidget(
                  color: Colors.green,
                  icon: Icons.repeat_sharp,
                  onTap: () {
                    cubit(context).onCompleteTapped();
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBar(
                        context: context,
                        label: LocaleKeys.todo_is_repeated.tr(),
                      ),
                    );
                  },
                )
              : IconButtonWidget(
                  color: Colors.green,
                  icon: Icons.check,
                  onTap: () {
                    cubit(context).onCompleteTapped();
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBar(
                        context: context,
                        label: LocaleKeys.todo_is_completed.tr(),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(width: 10),
        IconButtonWidget(
          color: Colors.red,
          icon: Icons.delete_forever,
          onTap: () => showTwoActionDialog(
            context: context,
            title: LocaleKeys.sure_want_delete.tr(),
            onConfirm: () async {
              await cubit(context).onDelete();
              _navigateBack();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateText(TodoState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${LocaleKeys.date.tr()} ${state.dateTime.day} ${numToMonth(state.dateTime.month)} ${state.dateTime.year}',
        ),
        const SizedBox(height: 10),
        Text(DateFormat.Hm().format(state.dateTime)),
      ],
    );
  }

  Widget _buildDatePickerButton({
    required BuildContext context,
    required TodoState state,
  }) {
    final theme = Theme.of(context);

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: IconButton(
        onPressed: () {
          DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            minTime: DateTime(2020, 1, 1),
            maxTime: DateTime(2026, 12, 31),
            onConfirm: (date) {
              cubit(context).onDateSelect(date);
            },
            currentTime: state.dateTime,
          );
        },
        icon: Icon(
          Icons.calendar_month,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
