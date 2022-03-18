import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

final routerDelegate = BeamerDelegate(
  initialPath: '/',
  locationBuilder: RoutesLocationBuilder(
    routes: <String, Widget Function(BuildContext, BeamState, Object?)>{},
  ),
);
