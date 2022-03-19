import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_myroshnykov/src/di/di_host.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/host_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/localization_widget.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/navigation/navigation.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/themes/themes.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/app_preferences/app_preferences_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/app_preferences/app_preferences_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    const DIHost(
      child: LocalizationWidget(
        child: HostCubit<AppPreferencesCubit>(
          child: AppPreferencesWidget(
            child: TodoAppMyroshnykov(),
          ),
        ),
      ),
    ),
  );
}

class TodoAppMyroshnykov extends StatelessWidget {
  const TodoAppMyroshnykov({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppPreferencesCubit, AppPreferencesState>(
      builder: (c, s) => MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        title: 'Todo App Myroshnykov',
        theme: Themes.purpleBlackOrange,
      ),
    );
  }
}
