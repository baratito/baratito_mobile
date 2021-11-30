import 'package:flutter/material.dart';

class View extends StatelessWidget {
  final Widget child;
  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? fab;
  final FloatingActionButtonLocation? fabLocation;

  const View({
    Key? key,
    required this.child,
    this.appBar,
    this.scaffoldKey,
    this.bottomNavigationBar,
    this.fab,
    this.fabLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
      body: SafeArea(child: child),
    );
  }
}
