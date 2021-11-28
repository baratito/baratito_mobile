import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_debounce_it/just_debounce_it.dart';

import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/ui/purchases/purchases.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_detail/shopping_list_detail_item_list.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_items_empty_illustration.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_detail/shopping_list_name_input.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_products/shopping_list_products_search_view.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class ShoppingListDetailView extends StatefulWidget {
  final ShoppingListCubit shoppingListCubit;
  final ShoppingListItemsCubit shoppingListItemsCubit;

  const ShoppingListDetailView({
    Key? key,
    required this.shoppingListCubit,
    required this.shoppingListItemsCubit,
  }) : super(key: key);

  @override
  _ShoppingListDetailViewState createState() => _ShoppingListDetailViewState();
}

class _ShoppingListDetailViewState extends State<ShoppingListDetailView> {
  @override
  Widget build(BuildContext context) {
    return View(
      appBar: MainAppBar(
        actions: [
          _buildAction(),
        ],
      ),
      child: _buildContent(),
    );
  }

  Widget _buildAction() {
    return SecondaryButton(
      label: 'shared.edit'.tr(),
      onTap: _openSearch,
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
    return BlocBuilder<ShoppingListCubit, ShoppingListState>(
      bloc: widget.shoppingListCubit,
      builder: (context, state) {
        if (state is ShoppingListLoaded) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                ),
                child: _buildName(state),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: padding,
                  top: context.responsive(12),
                ),
                child: _buildLabel(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      padding, context.responsive(16), padding, 0),
                  child: _buildItems(),
                ),
              ),
              _buildButtonBar(),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildName(ShoppingListLoaded state) {
    final shoppingList = state.shoppingList;
    return Row(
      children: [
        Flexible(
          child: ShoppingListNameInput(
            initialText: shoppingList.name,
            onChanged: _onNameChanged,
          ),
        )
      ],
    );
  }

  void _onNameChanged(String value) {
    Debounce.milliseconds(400, widget.shoppingListCubit.rename, [], {
      const Symbol('name'): value,
    });
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

  Widget _buildItems() {
    return BlocBuilder<ShoppingListItemsCubit, ShoppingListItemsState>(
      bloc: widget.shoppingListItemsCubit,
      builder: (context, state) {
        List<ShoppingListItem>? items;
        if (state is ShoppingListItemsData) {
          items = state.items;
          if (items.isEmpty) return _buildEmpty();
        }
        return ShoppingListDetailItemList(
          items: items,
          isLoading: state is ShoppingListItemsLoading,
        );
      },
    );
  }

  Widget _buildEmpty() {
    return FadeIn(
      child: Column(
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
      ),
    );
  }

  Widget _buildButtonBar() {
    return BlocBuilder<ShoppingListItemsCubit, ShoppingListItemsState>(
      bloc: widget.shoppingListItemsCubit,
      builder: (context, state) {
        if (state is ShoppingListItemsData) {
          final items = state.items;
          if (items.isEmpty) return Container();
          return ExtendedButtonBottomBar(
            label: 'shopping.start'.tr(),
            onPressed: () => _startPurchase(state.shoppingList),
          );
        }
        return Container();
      },
    );
  }

  void _startPurchase(ShoppingList shoppingList) {
    final purchaseCubit = getDependency<PurchaseCubit>();
    purchaseCubit.load(shoppingList: shoppingList);
    context.pushView(PurchaseSettingsSelectionView(
      purchaseCubit: purchaseCubit,
    ));
  }
}
