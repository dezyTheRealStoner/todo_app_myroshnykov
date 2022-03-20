import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/auth/auth_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/profile/profile_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';

class ProfileScreen extends CubitWidget<ProfileState, ProfileCubit> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const screenName = '/profile';

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarWidget(currentTabIndex: 2),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await cubit(context).onLogOut();
            Beamer.of(context).beamToNamed(AuthScreen.screenName);
          },
          child: Text(LocaleKeys.log_out.tr()),
        ),
      ),
    );
  }
}
