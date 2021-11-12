import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class MobilityModeButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onPressed;

  const MobilityModeButton({
    Key? key,
    required this.icon,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.theme.colors;
    final color = isSelected ? colorTheme.primary : colorTheme.greyAccent;
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      color: color.withOpacity(.2),
      child: InkWell(
        onTap: onPressed,
        splashColor: color.withOpacity(.05),
        highlightColor: color.withOpacity(.2),
        child: Padding(
          padding: EdgeInsets.all(context.responsive(16)),
          child: Icon(icon, color: color),
        ),
      ),
    );
    ;
  }
}
