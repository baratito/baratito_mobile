import 'package:baratito_core/baratito_core.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/products/lists/product_search_item.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

typedef OnProductPressed = void Function(Product);

class ProductsSearchList extends StatelessWidget {
  final List<Product> items;
  final bool hasNext;
  final VoidCallback onScrollEndReached;
  final OnProductPressed? onProductPressed;

  const ProductsSearchList({
    Key? key,
    required this.items,
    required this.hasNext,
    required this.onScrollEndReached,
    this.onProductPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfiniteList<Product>(
      items: items,
      itemBuilder: _buildItem,
      hasNext: hasNext,
      onScrollEndReached: onScrollEndReached,
      padding: EdgeInsets.only(top: context.responsive(16)),
    );
  }

  Widget _buildItem(BuildContext context, Product product) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(12)),
      child: ProductSearchItem(
        product: product,
        onPressed: () => _onPressed(product),
      ),
    );
  }

  void _onPressed(Product product) {
    if (onProductPressed != null) {
      onProductPressed!(product);
    }
  }
}
