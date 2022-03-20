import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/locale_keys.g.dart';
import 'package:todo_app_myroshnykov/src/presentation/dialogs/log_out_dialog.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/auth/auth_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/profile/profile_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/widgets/bottom_navigation_bar_widget.dart';

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
    return Column(
      children: [
        const SizedBox(height: 50),
        _buildImage(context, state),
        const SizedBox(height: 20),
        _buildName(context, state),
        const SizedBox(height: 20),
        _buildCompletedTodoText(context, state),
        const SizedBox(height: 60),
        _buildActionButton(
          context: context,
          title: LocaleKeys.theme.tr(),
          icon: Icons.color_lens,
          onTap: () {},
        ),
        _buildActionButton(
          context: context,
          title: LocaleKeys.language.tr(),
          icon: Icons.language,
          onTap: () {},
        ),
        const SizedBox(height: 80),
        _buildActionButton(
          context: context,
          title: LocaleKeys.log_out.tr(),
          icon: Icons.exit_to_app,
          onTap: () => showLogOutDialog(
            context: context,
            onConfirm: () async {
              await cubit(context).onLogOut();
              Beamer.of(context).beamToReplacementNamed(AuthScreen.screenName);
            },
          ),
        ),
      ],
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
    return Text(state.user.name);
  }

  Widget _buildCompletedTodoText(BuildContext context, ProfileState state) {
    final completedTodos =
        '${state.user.completedTodos}/${state.user.todoIds.length}';

    return Text('${LocaleKeys.completed_todos.tr()}: $completedTodos');
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 20),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                width: 50,
                child: Icon(icon),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
