import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/profile/profile_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todos/todos_screen.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    Key? key,
    required this.currentTabIndex,
  }) : super(key: key);

  final int currentTabIndex;

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        return _navigateTo(HomeScreen.screenName, context);
      case 1:
        return _navigateTo(TodosScreen.screenName, context);
      case 2:
        return _navigateTo(ProfileScreen.screenName, context);
    }
  }

  void _navigateTo(String screenName, BuildContext context) {
    Beamer.of(context).beamToNamed(
      screenName,
      transitionDelegate: const NoAnimationTransitionDelegate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentTabIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.colorScheme.background,
      selectedItemColor: theme.colorScheme.primary,
      unselectedFontSize: 14,
      unselectedItemColor: theme.colorScheme.secondary,
      onTap: (index) => _onTap(index, context),
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon('assets/images/home.png', 0, context),
          label: LocaleKeys.home.tr(),
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('assets/images/todo.png', 1, context),
          label: LocaleKeys.todos.tr(),
        ),
        BottomNavigationBarItem(
          icon: _buildIcon('assets/images/profile.png', 2, context),
          label: LocaleKeys.profile.tr(),
        ),
      ],
    );
  }

  Widget _buildIcon(
    String imageAsset,
    int tabIndex,
    BuildContext context,
  ) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image(
        image: AssetImage(imageAsset),
        color: tabIndex == currentTabIndex
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
