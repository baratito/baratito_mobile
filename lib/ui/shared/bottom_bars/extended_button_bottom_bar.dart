import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/bottom_bars/bottom_bar_base.dart';
import 'package:baratito_mobile/extensions/extensions.dart';

class ExtendedButtonBottomBar extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const ExtendedButtonBottomBar({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBarBase(
      elevated: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsive(24, axis: Axis.horizontal),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [..._buildItems(context)],
        ),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return [
      PrimaryButton.extended(
        label: label,
        onTap: onPressed,
      ),
    ];
  }
}
