import 'package:flutter/material.dart';

class View extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? fab;
  final FloatingActionButtonLocation? fabLocation;

  const View({
    Key? key,
    required this.child,
    this.bottomNavigationBar,
    this.fab,
    this.fabLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
      body: SafeArea(child: child),
    );
  }
}
