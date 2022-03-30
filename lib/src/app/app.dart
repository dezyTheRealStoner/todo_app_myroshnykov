import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/app/app_preferences_cubit.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_language.dart';
import 'package:todo_app_myroshnykov/src/domain/entities/personalization/user_theme.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/cubit_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/navigation/navigation.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/themes/themes.dart';

class TodoAppMyroshnykov
    extends CubitWidget<AppPreferencesState, AppPreferencesCubit> {
  const TodoAppMyroshnykov({Key? key}) : super(key: key);

  @override
  void initParams(BuildContext context) {
    cubit(context).checkUserAuthStatus();
  }

  @override
  void onStateChanged(BuildContext context, AppPreferencesState state) {
    if (state.user.language == UserLanguage.en) {
      context.setLocale(const Locale('en'));
    } else if (state.user.language == UserLanguage.uk) {
      context.setLocale(const Locale('uk'));
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return observeState(
      builder: (context, state) => MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        localizationsDelegates: context.localizationDelegates,
        locale: state.user.language == UserLanguage.en
            ? const Locale('en')
            : const Locale('uk'),
        supportedLocales: context.supportedLocales,
        title: 'Todo App Myroshnykov',
        theme: state.user.theme == UserTheme.light ? Themes.light : Themes.dark,
      ),
    );
  }
}
