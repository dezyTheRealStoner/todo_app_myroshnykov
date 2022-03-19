import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends CubitWidget<HomeState, HomeCubit> {
  const HomeScreen({Key? key}) : super(key: key);

  static const screenName = '/home';

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarWidget(currentTabIndex: 0),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            LocaleKeys.log_out.tr(),
          ),
        ),
      ),
    );
  }
}
