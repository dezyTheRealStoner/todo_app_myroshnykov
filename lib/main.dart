import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_myroshnykov/src/app/app.dart';
import 'package:todo_app_myroshnykov/src/app/app_preferences_cubit.dart';
import 'package:todo_app_myroshnykov/src/di/di_host.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/host_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/localization/localization_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
    const DIHost(
      child: LocalizationWidget(
        child: HostCubit<AppPreferencesCubit>(
          child: TodoAppMyroshnykov(),
        ),
      ),
    ),
  );
}
