import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/profile/profile_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';

class ProfileScreen extends CubitWidget<ProfileState, ProfileCubit> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const screenName = '/profile';

  @override
  Widget buildWidget(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(currentTabIndex: 2),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
