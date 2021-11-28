import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/products/search/square_category_item.dart';
import 'package:baratito_mobile/extensions/extensions.dart';

typedef OnCategoryPressed = void Function(Category);

class CategoriesGrid extends StatelessWidget {
  final OnCategoryPressed? onCategoryPressed;

  const CategoriesGrid({
    Key? key,
    this.onCategoryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: context.responsive(16)),
          child: Text(
            'products.categories_label'.tr(),
            style: context.theme.text.label,
          ),
        ),
        Expanded(
          child: _buildGrid(context),
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    final itemWidth = context.screenSize.width / 5.2;
    final itemHeight = context.screenSize.height / 8.2;
    const itemsPerRow = 3;
    // Removing Category.none, we don't want that rendered
    final allItems = Category.values.sublist(1);
    final itemsCount = allItems.length;
    final remainingItemsCount = itemsCount % itemsPerRow;
    final gridItems = allItems.sublist(0, itemsCount - remainingItemsCount);
    final rowItems = allItems.sublist(
      itemsCount - remainingItemsCount,
      itemsCount,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.count(
            childAspectRatio: itemWidth / itemHeight,
            crossAxisCount: itemsPerRow,
            shrinkWrap: true,
            children: [
              for (final item in gridItems) _buildItem(context, item),
            ],
          ),
          if (rowItems.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final item in rowItems) _buildItem(context, item)
              ],
            )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, Category category) {
    return SquareCategoryItem(
      category: category,
      onPressed: () {
        if (onCategoryPressed != null) {
          onCategoryPressed!(category);
        }
      },
    );
  }
}
