import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/products/search/category_item.dart';

typedef OnCategoryPressed = void Function(Category);

class CategoriesList extends StatelessWidget {
  final OnCategoryPressed? onCategoryPressed;

  const CategoriesList({
    Key? key,
    this.onCategoryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: context.responsive(12)),
          child: Text(
            'products.categories_label'.tr(),
            style: context.theme.text.label,
          ),
        ),
        Expanded(
          child: _buildList(context),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    // Removing Category.none, we don't want that rendered
    final items = Category.values.sublist(1);
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return _buildItem(context, item);
      },
    );
  }

  Widget _buildItem(BuildContext context, Category category) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(12)),
      child: CategoryItem(
        category: category,
        onPressed: () {
          if (onCategoryPressed != null) {
            onCategoryPressed!(category);
          }
        },
      ),
    );
  }
}
