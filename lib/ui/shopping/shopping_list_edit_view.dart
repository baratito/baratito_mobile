import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shopping/shopping_list_item_edit_tile.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_items_empty_illustration.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_products_search_view.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListEditView extends StatefulWidget {
  final ShoppingListItemsCubit shoppingListItemsCubit;

  const ShoppingListEditView({
    Key? key,
    required this.shoppingListItemsCubit,
  }) : super(key: key);

  @override
  _ShoppingListEditViewState createState() => _ShoppingListEditViewState();
}

class _ShoppingListEditViewState extends State<ShoppingListEditView> {
  @override
  Widget build(BuildContext context) {
    return View(
      appBar: MainAppBar(
        title: 'shopping.edit_products'.tr(),
        actions: [
          IconActionButton(
            icon: BaratitoIcons.plus,
            onTap: _openSearch,
          )
        ],
      ),
      child: _buildContent(),
    );
  }

  void _openSearch() {
    final productsSearchCubit = getDependency<ProductsSearchCubit>();
    context.pushView(
      ShoppingListProductsSearchView(
        productsSearchCubit: productsSearchCubit,
        shoppingListItemsCubit: widget.shoppingListItemsCubit,
      ),
    );
  }

  Widget _buildContent() {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return BlocBuilder<ShoppingListItemsCubit, ShoppingListItemsState>(
      bloc: widget.shoppingListItemsCubit,
      builder: (context, state) {
        if (state is ShoppingListItemsData) {
          final items = state.items;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: context.responsive(12),
                  left: padding,
                ),
                child: _buildLabel(),
              ),
              Expanded(child: _buildItems(items)),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLabel() {
    return Row(
      children: [
        Flexible(
          child: Text(
            'shopping.products_label'.tr(),
            style: context.theme.text.label,
          ),
        )
      ],
    );
  }

  Widget _buildItems(List<ShoppingListItem> items) {
    if (items.isEmpty) return _buildEmpty();
    return ListView.builder(
      padding: EdgeInsets.only(top: context.responsive(40)),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return _buildTile(item);
      },
    );
  }

  Widget _buildTile(ShoppingListItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(40)),
      child: ShoppingListItemEditTile(
        item: item,
        onAddPressed: () => _addToItem(item),
        onSubtractPressed: () => _subtractFromItem(item),
      ),
    );
  }

  void _addToItem(ShoppingListItem item) {
    widget.shoppingListItemsCubit.updateItemQuantity(
      item: item,
      quantity: item.quantity + 1,
    );
  }

  void _subtractFromItem(ShoppingListItem item) {
    widget.shoppingListItemsCubit.updateItemQuantity(
      item: item,
      quantity: item.quantity - 1,
    );
  }

  Widget _buildEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ShoppingListItemsEmptyIllustration(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.responsive(36),
          ),
          child: Text(
            'shopping.shopping_list_items_empty'.tr(),
            textAlign: TextAlign.center,
            style: context.theme.text.body,
          ),
        ),
      ],
    );
  }
}
