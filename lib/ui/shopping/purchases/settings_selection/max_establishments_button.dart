import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class MaxEstablishmentsButton extends StatelessWidget {
  final int number;
  final bool isSelected;
  final VoidCallback? onPressed;

  const MaxEstablishmentsButton({
    Key? key,
    required this.number,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.theme.colors;
    final color = isSelected ? colorTheme.primary : colorTheme.greyAccent;
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: color.withOpacity(.2),
      child: InkWell(
        onTap: onPressed,
        splashColor: color.withOpacity(.05),
        highlightColor: color.withOpacity(.2),
        child: Padding(
          padding: EdgeInsets.all(context.responsive(20)),
          child: Text(
            '$number',
            style: context.theme.text.primaryButton.copyWith(color: color),
          ),
        ),
      ),
    );
    ;
  }
}
