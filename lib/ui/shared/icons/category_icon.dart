import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/utils/utils.dart';

class CategoryIcon extends StatelessWidget {
  final double? size;
  final Category category;

  const CategoryIcon({
    Key? key,
    required this.category,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? context.theme.dimensions.iconRegular;
    final icon = category.getIcon();
    final color = category.getColor(context);

    return Icon(icon, size: iconSize, color: color);
  }
}
