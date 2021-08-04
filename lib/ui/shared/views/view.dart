import 'package:flutter/material.dart';

class View extends StatelessWidget {
  final Widget child;

  const View({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
    );
  }
}
