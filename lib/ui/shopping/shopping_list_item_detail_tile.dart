import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/utils/category_extension.dart';

class ShoppingListItemDetailTile extends StatelessWidget {
  final ShoppingListItem item;

  const ShoppingListItemDetailTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItemBase(
      title: item.product.name,
      subtitle1: item.product.category.getLocalizationKey().tr(),
      leading: _buildLeading(context),
      trailing: _buildTrailing(context),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: context.responsive(16, axis: Axis.horizontal),
      ),
      child: NetworkImageSquircle(
        imageUrl: item.product.imageUrl,
        fallbackWidget: const IconSquircle(icon: BaratitoIcons.bag),
        loadingWidget: const IconSquircle(icon: BaratitoIcons.bag),
      ),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.responsive(16, axis: Axis.horizontal),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: context.theme.colors.primary.withOpacity(.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '${item.quantity}',
          style: context.theme.text.primaryButton.copyWith(
            color: context.theme.colors.primary,
          ),
        ),
      ),
    );
  }
}
