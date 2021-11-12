import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class EstablishmentsDistanceButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  const EstablishmentsDistanceButton({
    Key? key,
    required this.label,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.theme.colors;
    final color = isSelected ? colorTheme.primary : colorTheme.greyAccent;
    return Material(
      borderRadius: BorderRadius.circular(32),
      clipBehavior: Clip.antiAlias,
      color: color.withOpacity(.2),
      child: InkWell(
        onTap: onPressed,
        splashColor: color.withOpacity(.05),
        highlightColor: color.withOpacity(.2),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive(20),
            vertical: context.responsive(12),
          ),
          child: Text(
            label,
            style: context.theme.text.primaryButton.copyWith(color: color),
          ),
        ),
      ),
    );
    ;
  }
}
