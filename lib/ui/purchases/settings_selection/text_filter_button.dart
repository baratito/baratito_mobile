import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class TextFilterButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isSelected;

  const TextFilterButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.isSelected = false,
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
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(12),
            horizontal: context.responsive(16, axis: Axis.horizontal),
          ),
          child: Text(
            label,
            style: context.theme.text.primaryButton.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}
