import 'package:flutter/material.dart';

enum RouteTransitionType {
  systemDefault,
  fade,
}

extension NavigationExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  Future<T?> pushView<T>(
    Widget view, [
    RouteTransitionType transitionType = RouteTransitionType.systemDefault,
  ]) async {
    return navigator.push<T>(_buildRoute<T>(view, transitionType));
  }

  Future<T?> pushReplacementView<T>(
    Widget view, [
    RouteTransitionType transitionType = RouteTransitionType.systemDefault,
  ]) async {
    return navigator.pushReplacement<T, T>(
      _buildRoute<T>(view, transitionType),
    );
  }

  Future<bool> popView<R>({R? result}) async => navigator.maybePop(result);
}

Route<T> _buildRoute<T>(
  Widget view, [
  RouteTransitionType transitionType = RouteTransitionType.systemDefault,
]) {
  final settings = RouteSettings(name: '${view.runtimeType}');
  switch (transitionType) {
    case RouteTransitionType.systemDefault:
      return MaterialPageRoute<T>(
        settings: settings,
        builder: (context) => view,
      );
    case RouteTransitionType.fade:
      return FadeRoute<T>(
        routeSettings: settings,
        view: view,
      );
  }
}

class FadeRoute<T> extends PageRouteBuilder<T> {
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
