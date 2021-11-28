import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/ui/shopping/shopping_list_products/shopping_list_item_edit_tile.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_items_empty_illustration.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class ShoppingListProductsSheet extends StatelessWidget {
  final ShoppingListItemsCubit shoppingListItemsCubit;

  const ShoppingListProductsSheet({
    Key? key,
    required this.shoppingListItemsCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const minRatio = .8;
    const maxRatio = 1.0;
    return DraggableScrollableSheet(
      expand: true,
      snap: true,
      initialChildSize: minRatio,
      maxChildSize: maxRatio,
      minChildSize: minRatio,
      builder: (_, scrollController) {
        return BottomSheetBase(
          title: 'shopping.selected_products'.tr(),
          child: _buildContent(context, scrollController),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    ScrollController scrollController,
  ) {
    return BlocBuilder<ShoppingListItemsCubit, ShoppingListItemsState>(
      bloc: shoppingListItemsCubit,
      builder: (context, state) {
        if (state is ShoppingListItemsData) {
          final items = state.items;
          return _buildItems(context, items, scrollController);
        }
        return Container();
      },
    );
  }

  Widget _buildItems(
    BuildContext context,
    List<ShoppingListItem> items,
    ScrollController scrollController,
  ) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    if (items.isEmpty) return _buildEmpty(context, padding);
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: padding,
              top: context.responsive(12),
            ),
            child: _buildLabel(context),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: context.responsive(16)),
              itemCount: items.length,
              controller: scrollController,
              itemBuilder: (_, index) {
                final item = items[index];
                return _buildTile(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            'shopping.all_products'.tr(),
            style: context.theme.text.label,
          ),
        )
      ],
    );
  }

  Widget _buildTile(BuildContext context, ShoppingListItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: context.responsive(8)),
            child: ShoppingListItemEditTile(
              item: item,
              onAddPressed: () => _addToItem(item),
              onSubtractPressed: () => _subtractFromItem(item),
            ),
          ),
          Divider(color: context.theme.colors.greyBackground.withOpacity(.3))
        ],
      ),
    );
  }

  void _addToItem(ShoppingListItem item) {
    shoppingListItemsCubit.updateItemQuantity(
      item: item,
      quantity: item.quantity + 1,
    );
  }

  void _subtractFromItem(ShoppingListItem item) {
    shoppingListItemsCubit.updateItemQuantity(
      item: item,
      quantity: item.quantity - 1,
    );
  }

  Widget _buildEmpty(BuildContext context, double padding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        padding,
        context.responsive(32),
        padding,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ShoppingListItemsEmptyIllustration(width: 160),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: context.responsive(36)),
              child: Text(
                'shopping.shopping_list_items_empty'.tr(),
                textAlign: TextAlign.center,
                style: context.theme.text.body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
