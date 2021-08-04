import 'package:flutter/material.dart';

enum RouteTransitionType {
  systemDefault,
  fade,
}

extension NavigationExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  Future<T> pushView<T>(
    Widget view, [
    RouteTransitionType transitionType = RouteTransitionType.systemDefault,
  ]) async {
    return await navigator.push(_buildRoute(view, transitionType));
  }

  Future<T> pushReplacementView<T>(
    Widget view, [
    RouteTransitionType transitionType = RouteTransitionType.systemDefault,
  ]) async {
    return await navigator.pushReplacement(_buildRoute(view, transitionType));
  }
}

Route _buildRoute(
  Widget view, [
  RouteTransitionType transitionType = RouteTransitionType.systemDefault,
]) {
  final settings = RouteSettings(name: '${view.runtimeType}');
  switch (transitionType) {
    case RouteTransitionType.systemDefault:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => view,
      );
    case RouteTransitionType.fade:
      return FadeRoute(
        routeSettings: settings,
        view: view,
      );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget view;
  final RouteSettings? routeSettings;

  FadeRoute({required this.view, this.routeSettings})
      : super(
          settings: routeSettings,
          pageBuilder: (_, __, ___) => view,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
}
