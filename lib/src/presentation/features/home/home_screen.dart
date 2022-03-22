import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/todo_card_widget.dart';

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
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildTitle(),
        const SizedBox(height: 20),
        _buildProgress(),
        const SizedBox(height: 20),
        _buildList(context),
        const SizedBox(height: 20),
        _buildAddButton(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(LocaleKeys.your_coming_todos.tr());
  }

  Widget _buildProgress() {
    return Container();
  }

  Widget _buildList(BuildContext context) {
    return observeState(
      builder: (context, state) => Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1),
          ),
          child: state.updating
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) => TodoCardWidget(
                    todo: state.todoList.elementAt(index),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
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
        LocaleKeys.add_todo.tr(),
      ),
    );
  }
}
