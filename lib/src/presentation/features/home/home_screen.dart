import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/add_todo/add_todo_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends CubitWidget<HomeState, HomeCubit> {
  const HomeScreen({Key? key}) : super(key: key);

  static const screenName = '/home';

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
    return Text(LocaleKeys.your_todos_for_today.tr());
  }

  Widget _buildProgress() {
    return Container();
  }

  Widget _buildList(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1)),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => ListTile(
            title: Text(index.toString()),
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
      onPressed: () => Beamer.of(context).beamToNamed(AddTodoScreen.screenName),
      child: Text(
        LocaleKeys.add_todo.tr(),
      ),
    );
  }
}
