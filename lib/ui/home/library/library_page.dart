import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/library/shopping_lists/shopping_lists.dart';

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
    return ShoppingListsLibrary(
      shoppingListsCubit: widget.shoppingListsCubit,
    );
  }
}
