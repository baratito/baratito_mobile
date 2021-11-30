import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/ui/home/library/shopping_lists/shopping_list_tile.dart';
import 'package:baratito_mobile/ui/home/library/shopping_lists/shopping_lists_library_empty_illustration.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shopping/shopping.dart';
import 'package:baratito_mobile/ui/shared/bottom_sheets/bottom_sheets.dart';

class ShoppingListsLibrary extends StatelessWidget {
  final ShoppingListsCubit shoppingListsCubit;

  const ShoppingListsLibrary({
    Key? key,
    required this.shoppingListsCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListsCubit, ShoppingListsState>(
      bloc: shoppingListsCubit,
      builder: (context, state) {
        if (state is ShoppingListsLoading) return _buildLoading(context);
        if (state is ShoppingListsEmpty) return _buildEmpty(context);
        if (state is ShoppingListsData) {
          return _buildContent(context, state);
        }
        return Container();
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.responsive(context.screenSize.height / 2.5),
      ),
      child: Column(
        children: const [Spinner()],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return FadeIn(
      child: Padding(
        padding: EdgeInsets.only(
          top: context.responsive(context.screenSize.height / 4),
        ),
        child: Column(
          children: [
            const ShoppingListsLibraryEmptyIllustration(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.responsive(36),
              ),
              child: Text(
                'shopping.shopping_lists_empty'.tr(),
                textAlign: TextAlign.center,
                style: context.theme.text.body,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ShoppingListsData state) {
    return Padding(
      padding: EdgeInsets.only(top: context.responsive(20)),
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                Text(
                  'lists.all_your_lists'.tr(),
                  textAlign: TextAlign.center,
                  style: context.theme.text.body,
                ),
              ],
            ),
          ),
          Expanded(child: _buildLists(context, state)),
        ],
      ),
    );
  }

  Widget _buildLists(BuildContext context, ShoppingListsData state) {
    final shoppingLists = state.shoppingLists;
    return RefreshIndicator(
      onRefresh: () => shoppingListsCubit.get(),
      color: Colors.white,
      backgroundColor: context.theme.colors.primary,
      child: ListView.builder(
        padding: EdgeInsets.only(top: context.responsive(16)),
        itemCount: shoppingLists.length,
        itemBuilder: (_, index) {
          return _buildListItem(context, shoppingLists[index]);
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, ShoppingList shoppingList) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(12)),
      child: ShoppingListTile(
        shoppingList: shoppingList,
        onPressed: () => _onItemPressed(context, shoppingList),
        onLongPressed: () => _onItemLongPressed(context, shoppingList),
      ),
    );
  }

  void _onItemPressed(BuildContext context, ShoppingList shoppingList) {
    final shoppingListCubit = getDependency<ShoppingListCubit>();
    final shoppingListItemsCubit = getDependency<ShoppingListItemsCubit>();
    shoppingListCubit.load(
      shoppingListsCubit: shoppingListsCubit,
      shoppingList: shoppingList,
    );
    shoppingListItemsCubit.load(shoppingList: shoppingList);
    context.pushView(ShoppingListDetailView(
      shoppingListCubit: shoppingListCubit,
      shoppingListItemsCubit: shoppingListItemsCubit,
    ));
  }

  void _onItemLongPressed(BuildContext context, ShoppingList shoppingList) {
    context.showBottomSheet(_DeleteBottomSheet(
      shoppingList: shoppingList,
      onDeletePressed: () {
        shoppingListsCubit.delete(shoppingList: shoppingList);
      },
    ));
  }
}

class _DeleteBottomSheet extends StatelessWidget {
  final ShoppingList shoppingList;
  final VoidCallback onDeletePressed;

  const _DeleteBottomSheet({
    Key? key,
    required this.shoppingList,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .35,
      expand: false,
      builder: (_, scrollController) {
        return BottomSheetBase(
          title: shoppingList.name,
          child: _buildButtonList(context),
        );
      },
    );
  }

  Widget _buildButtonList(BuildContext context) {
    final padding = (context.theme.dimensions as MobileDimensionTheme)
        .viewHorizontalPadding;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListItemBase(
            title: 'shared.delete'.tr(),
            onPressed: () {
              onDeletePressed();
              context.popView();
            },
          ),
        ],
      ),
    );
  }
}
