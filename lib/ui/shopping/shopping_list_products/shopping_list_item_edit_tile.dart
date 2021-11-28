import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class ShoppingListItemEditTile extends StatelessWidget {
  final ShoppingListItem item;
  final VoidCallback? onSubtractPressed;
  final VoidCallback? onAddPressed;

  const ShoppingListItemEditTile({
    Key? key,
    required this.item,
    this.onSubtractPressed,
    this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive(12, axis: Axis.horizontal),
          ),
          child: _buildSubtractButton(context),
        ),
        Expanded(child: _buildItem(context)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive(12, axis: Axis.horizontal),
          ),
          child: _buildAddButton(context),
        ),
      ],
    );
  }

  Widget _buildSubtractButton(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        onTap: onSubtractPressed,
        splashColor: context.theme.colors.redAccent.withOpacity(.05),
        highlightColor: context.theme.colors.redAccent.withOpacity(.2),
        child: Padding(
          padding: EdgeInsets.all(context.responsive(8)),
          child: Icon(Icons.remove, color: context.theme.colors.redAccent),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        onTap: onAddPressed,
        splashColor: context.theme.colors.greenAccent.withOpacity(.05),
        highlightColor: context.theme.colors.greenAccent.withOpacity(.2),
        child: Padding(
          padding: EdgeInsets.all(context.responsive(8)),
          child: Icon(Icons.add, color: context.theme.colors.greenAccent),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return ListItemBase(
      title: item.product.name,
      subtitle1: item.product.presentation,
      subtitle2: _getQuantitySubtitle(),
      subtitle2Color: context.theme.colors.primary,
    );
  }

  String _getQuantitySubtitle() {
    final selected = 'shopping.selected'.tr();
    return '${item.quantity} $selected';
  }
}
