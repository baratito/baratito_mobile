import 'package:flutter/material.dart';

class View extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? fab;
  final FloatingActionButtonLocation? fabLocation;

  const View({
    Key? key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.fab,
    this.fabLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
      body: SafeArea(child: child),
    );
  }
}
