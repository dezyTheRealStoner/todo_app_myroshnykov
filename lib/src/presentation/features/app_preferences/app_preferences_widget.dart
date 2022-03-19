import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/app_preferences/app_preferences_cubit.dart';

class AppPreferencesWidget
    extends CubitWidget<AppPreferencesState, AppPreferencesCubit> {
  const AppPreferencesWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  void initParams(BuildContext context) {
    cubit(context).checkUserAuthStatus();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return child;
  }
}
