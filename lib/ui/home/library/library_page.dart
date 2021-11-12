import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/ui/shared/bottom_sheets/bottom_sheets.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shopping/shopping.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatefulWidget {
  final ShoppingListsCubit shoppingListsCubit;

  const LibraryPage({
    Key? key,
    required this.shoppingListsCubit,
  }) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    widget.shoppingListsCubit.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, context.responsive(24), padding, 0),
      child: Column(
        children: [
          _buildTitle(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Flexible(
          child: Text(
            'shopping.shopping_lists'.tr(),
            style: context.theme.text.title,
          ),
        )
      ],
    );
  }

  Widget _buildContent() {
    return BlocBuilder<ShoppingListsCubit, ShoppingListsState>(
      bloc: widget.shoppingListsCubit,
      builder: (context, state) {
        if (state is ShoppingListsLoading) return _buildLoading();
        if (state is ShoppingListsEmpty) return _buildEmpty();
        if (state is ShoppingListsData) return _buildLists(state);
        return Container();
      },
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: EdgeInsets.only(
        top: context.responsive(context.screenSize.height / 2.5),
      ),
      child: Column(
        children: const [Spinner()],
      ),
    );
  }

  Widget _buildEmpty() {
    return Padding(
      padding: EdgeInsets.only(
        top: context.responsive(context.screenSize.height / 4.5),
      ),
      child: Column(
        children: [
          const ShoppingListsEmptyIllustration(),
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
    );
  }

  Widget _buildLists(ShoppingListsData state) {
    final shoppingLists = state.shoppingLists;
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => widget.shoppingListsCubit.get(),
        color: Colors.white,
        backgroundColor: context.theme.colors.primary,
        child: ListView.builder(
          padding: EdgeInsets.only(top: context.responsive(12)),
          itemCount: shoppingLists.length,
          itemBuilder: (_, index) => _buildListItem(shoppingLists[index]),
        ),
      ),
    );
  }

  Widget _buildListItem(ShoppingList shoppingList) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(12)),
      child: ShoppingListTile(
        shoppingList: shoppingList,
        onPressed: () => _onItemPressed(shoppingList),
        onLongPressed: () => _onItemLongPressed(shoppingList),
      ),
    );
  }

  void _onItemPressed(ShoppingList shoppingList) {
    final shoppingListCubit = getDependency<ShoppingListCubit>();
    final shoppingListItemsCubit = getDependency<ShoppingListItemsCubit>();
    shoppingListCubit.load(shoppingList: shoppingList);
    shoppingListItemsCubit.load(shoppingList: shoppingList);
    context.pushView(ShoppingListDetailView(
      shoppingListCubit: shoppingListCubit,
      shoppingListItemsCubit: shoppingListItemsCubit,
    ));
  }

  void _onItemLongPressed(ShoppingList shoppingList) {
    context.showBottomSheet(_DeleteBottomSheet(
      shoppingList: shoppingList,
      onDeletePressed: () {
        widget.shoppingListsCubit.delete(shoppingList: shoppingList);
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
