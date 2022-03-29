import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_myroshnykov/src/app/app_preferences_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/base/cubit/host_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/todo/todo_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/auth/auth_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/auth/auth_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/home/home_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/profile/profile_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/profile/profile_screen.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/all_todos/all_todos_cubit.dart';
import 'package:todo_app_myroshnykov/src/presentation/features/all_todos/all_todos_screen.dart';

final routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
      pathPatterns: <String>[
        AuthScreen.screenName,
      ],
      guardNonMatching: true,
      check: (context, location) =>
          BlocProvider.of<AppPreferencesCubit>(context).state.userIsLogged,
      beamToNamed: (origin, target) => AuthScreen.screenName,
    )
  ],
  initialPath: HomeScreen.screenName,
  locationBuilder: RoutesLocationBuilder(
    routes: <String, Widget Function(BuildContext, BeamState, Object?)>{
      AuthScreen.screenName: (c, s, o) => const HostCubit<AuthCubit>(
            child: AuthScreen(),
          ),
      HomeScreen.screenName: (c, s, o) => const HostCubit<HomeCubit>(
            child: HomeScreen(),
          ),
      AllTodosScreen.screenName: (c, s, o) => const HostCubit<AllTodosCubit>(
            child: AllTodosScreen(),
          ),
      ProfileScreen.screenName: (c, s, o) => const HostCubit<ProfileCubit>(
            child: ProfileScreen(),
          ),
      TodoScreen.screenName: (c, s, o) => const HostCubit<TodoCubit>(
            child: TodoScreen(),
          ),
    },
  ),
);
