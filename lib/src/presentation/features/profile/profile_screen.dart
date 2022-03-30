import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_language.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_theme.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/dialogs/two_action_dialog.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/auth/auth_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/profile/profile_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/outlined_button_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/switcher_button_widget.dart';

class ProfileScreen extends CubitWidget<ProfileState, ProfileCubit> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const screenName = '/profile';

  @override
  void initParams(BuildContext context) {
    cubit(context).getProfileInfo();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return observeState(
      builder: (context, state) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar:
            const BottomNavigationBarWidget(currentTabIndex: 2),
        body: SafeArea(
          child: Center(
            child: state.updating
                ? const CircularProgressIndicator()
                : _buildBody(context, state),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProfileState state,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          _buildImage(context, state),
          const SizedBox(height: 20),
          _buildName(context, state),
          const SizedBox(height: 20),
          _buildCompletedTodoText(context, state),
          const SizedBox(height: 60),
          OutlinedButtonWidget(
            title: LocaleKeys.theme.tr(),
            icon: Icons.color_lens,
            onTap: () => cubit(context).onTapThemeButton(),
            switcherButtons: [
              SwitcherButtonWidget(
                selected: state.lightThemeSelected,
                title: LocaleKeys.light_theme.tr(),
                onTap: () => cubit(context).onThemeSelected(UserTheme.light),
              ),
              SwitcherButtonWidget(
                selected: state.darkThemeSelected,
                title: LocaleKeys.dark_theme.tr(),
                onTap: () {
                  cubit(context).onThemeSelected(UserTheme.dark);
                },
              ),
            ],
            buttonIsOpen: state.openThemeButton,
          ),
          OutlinedButtonWidget(
            title: LocaleKeys.language.tr(),
            icon: Icons.language,
            onTap: () => cubit(context).onTapLanguageButton(),
            switcherButtons: [
              SwitcherButtonWidget(
                selected: state.englishLanguageSelected,
                title: LocaleKeys.english.tr(),
                onTap: () {
                  cubit(context).onLanguageSelected(UserLanguage.en);
                },
              ),
              SwitcherButtonWidget(
                selected: state.ukrainianLanguageSelected,
                title: LocaleKeys.ukrainian.tr(),
                onTap: () {
                  cubit(context).onLanguageSelected(UserLanguage.uk);
                },
              ),
            ],
            buttonIsOpen: state.openLanguageButton,
          ),
          const SizedBox(height: 80),
          OutlinedButtonWidget(
            title: LocaleKeys.log_out.tr(),
            icon: Icons.exit_to_app,
            onTap: () => showTwoActionDialog(
              context: context,
              title: LocaleKeys.sure_about_log_out.tr(),
              onConfirm: () async {
                await cubit(context).onLogOut();
                Beamer.of(context)
                    .beamToReplacementNamed(AuthScreen.screenName);
              },
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }

  Widget _buildImage(
    BuildContext context,
    ProfileState state,
  ) {
    return Container(
      height: 80,
      width: 80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Image.network(state.user.image),
    );
  }

  Widget _buildName(BuildContext context, ProfileState state) {
    return Text(
      state.user.name,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildCompletedTodoText(BuildContext context, ProfileState state) {
    final text =
        '${LocaleKeys.completed_todos.tr()}: ${state.completedTodos}/${state.user.todoIds.length}';

    return Text(
      text,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    );
  }
}
