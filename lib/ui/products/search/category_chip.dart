import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/icons/icons.dart';
import 'package:baratito_mobile/ui/shared/utils/utils.dart';

class CategoryChip extends StatelessWidget {
  final Category category;

  const CategoryChip({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = category.getColor(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: _buildContent(context, color),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Color color) {
    final name = category.getLocalizationKey().tr();
    final textStyle = context.theme.text.label.copyWith(color: color);
    final iconSize = textStyle.fontSize;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CategoryIcon(category: category, size: iconSize),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: AutoSizeText(name, style: textStyle),
          ),
        ),
      ],
    );
  }
}
