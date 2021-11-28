import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/utils/utils.dart';

class SquareCategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback? onPressed;

  const SquareCategoryItem({
    Key? key,
    required this.category,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = category.getColor(context);
    final name = category.getLocalizationKey().tr();
    final icon = category.getIcon();
    return _SquareLabelButton(
      label: name,
      icon: icon,
      color: color,
      onPressed: onPressed,
    );
  }
}

class _SquareLabelButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;

  const _SquareLabelButton({
    Key? key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.screenSize.width / 5.2;
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconButton(context, width),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: context.responsive(12)),
              child: _buildLabel(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, double size) {
    final _color = color ?? context.theme.colors.primary;
    final iconSize = size / 2;
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      highlightColor: _color.withOpacity(.2),
      splashColor: _color.withOpacity(.05),
      onTap: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: _color.withOpacity(
            context.isDarkmodeActive ? .1 : .25,
          ),
        ),
        child: Center(child: Icon(icon, size: iconSize, color: _color)),
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    final textStyle = context.theme.text.body;
    return AutoSizeText(
      label,
      style: textStyle,
      maxLines: 2,
      textAlign: TextAlign.center,
      maxFontSize: 13,
      minFontSize: 11,
    );
  }
}
