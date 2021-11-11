import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/bottom_bars/bottom_bar_base.dart';
import 'package:baratito_mobile/extensions/extensions.dart';

class DoubleButtonBottomBar extends StatelessWidget {
  final String leftButtonLabel;
  final VoidCallback? onLeftButtonPressed;
  final String rightButtonLabel;
  final VoidCallback? onRightButtonPressed;

  const DoubleButtonBottomBar({
    Key? key,
    required this.leftButtonLabel,
    required this.rightButtonLabel,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [..._buildItems(context)],
        ),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return [
      SecondaryButton(label: leftButtonLabel, onTap: onLeftButtonPressed),
      Expanded(
          child: Padding(
        padding: EdgeInsets.only(left: context.responsive(16)),
        child: PrimaryButton(
          label: rightButtonLabel,
          onTap: onRightButtonPressed,
        ),
      )),
    ];
  }
}
