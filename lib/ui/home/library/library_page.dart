import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/home/library/summaries/summaries.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/library/shopping_lists/shopping_lists.dart';

class LibraryPage extends StatefulWidget {
  final ShoppingListsCubit shoppingListsCubit;
  final MonthlyPurchaseSummariesCubit summariesCubit;

  const LibraryPage({
    Key? key,
    required this.shoppingListsCubit,
    required this.summariesCubit,
  }) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    widget.shoppingListsCubit.get();
    widget.summariesCubit.get();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTabs(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final theme = context.theme.text.title;
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        labelPadding: EdgeInsets.only(
          right: context.responsive(16, axis: Axis.horizontal),
        ),
        labelStyle: theme,
        unselectedLabelColor: theme.color!.withOpacity(.4),
        tabs: [
          Tab(text: 'shopping.shopping_lists'.tr()),
          Tab(text: 'purchases.title'.tr()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ShoppingListsLibrary(shoppingListsCubit: widget.shoppingListsCubit),
        PurchaseSummaries(summariesCubit: widget.summariesCubit),
      ],
    );
  }
}
