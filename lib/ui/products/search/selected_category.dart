import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/products/search/category_chip.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SelectedCategory extends StatelessWidget {
  final Category category;
  final VoidCallback? onUnselectPressed;

  const SelectedCategory({
    Key? key,
    required this.category,
    this.onUnselectPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'products.browsing'.tr(),
          style: context.theme.text.label,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CategoryChip(category: category),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: _buildUnselectButton(context),
        ),
      ],
    );
  }

  Widget _buildUnselectButton(BuildContext context) {
    final iconSize = context.theme.text.label.fontSize;
    final color = context.theme.colors.greyAccent;
    const buttonSize = 28.0;
    return InkWell(
      onTap: onUnselectPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(.2),
        ),
        child: Icon(
          BaratitoIcons.close,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
