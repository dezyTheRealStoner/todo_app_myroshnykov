import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_state.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/add_todo/add_todo_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/utils/num_to_month.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/outlined_input_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/submit_button_widget.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  static const screenName = '/addTodo';

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState
    extends CubitState<AddTodoScreen, AddTodoState, AddTodoCubit> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initParams(BuildContext context) {
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
    Beamer.of(context).popToNamed(HomeScreen.screenName);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.add_todo.tr().toUpperCase()),
        leading: BackButton(
          onPressed: () => _navigateBack(),
        ),
      ),
      body: SingleChildScrollView(
        child: _buildBody(context),
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
            const SizedBox(height: 10),
            _buildDateText(state),
            const SizedBox(height: 10),
            _buildDatePickerButton(
              context: context,
              state: state,
            ),
            const SizedBox(height: 50),
            SubmitButtonWidget(
              title: LocaleKeys.submit.tr(),
              onPressed: () async {
                await cubit(context).onTodoAdded();
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

  Widget _buildDateText(AddTodoState state) {
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
    required AddTodoState state,
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
            currentTime: DateTime.now(),
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
