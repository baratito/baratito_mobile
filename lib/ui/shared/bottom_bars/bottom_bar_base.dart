import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class BottomBarBase extends StatelessWidget {
  final bool elevated;
  final Widget child;

  const BottomBarBase({
    Key? key,
    required this.child,
    this.elevated = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.screenSize.width;
    final height =
        (context.theme.dimensions as MobileDimensionTheme).navigationBarHeight;
    return Container(
      height: context.responsive(height),
      width: width,
      decoration: BoxDecoration(
        color: context.theme.colors.background,
        boxShadow: elevated ? [context.theme.shadows.large] : null,
      ),
      child: child,
    );
  }
}
