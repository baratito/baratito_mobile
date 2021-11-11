import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/icons/icons.dart';
import 'package:baratito_mobile/ui/shared/utils/utils.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final VoidCallback? onPressed;

  const CategoryItem({
    Key? key,
    required this.category,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = category.getColor(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      highlightColor: color.withOpacity(.2),
      splashColor: color.withOpacity(.05),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(
            context.isDarkmodeActive ? .1 : .25,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildContent(context, color),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Color color) {
    final name = category.getLocalizationKey().tr();
    final textStyle = context.theme.text.body.copyWith(color: color);
    final iconSize = context.theme.dimensions.squircleContainerIcon;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CategoryIcon(category: category, size: iconSize),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: AutoSizeText(name, style: textStyle),
          ),
        ),
      ],
    );
  }
}
