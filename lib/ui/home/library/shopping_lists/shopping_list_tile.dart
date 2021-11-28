import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ShoppingListTile extends StatelessWidget {
  final ShoppingList shoppingList;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const ShoppingListTile({
    Key? key,
    required this.shoppingList,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconListItem(
      title: shoppingList.name,
      subtitle1: 'shopping.shopping_list'.tr(),
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      iconColor: shoppingList.color,
      icon: BaratitoIcons.category,
      actionIcon: BaratitoIcons.arrowRight,
    );
  }
}
