import 'package:collection/collection.dart';
import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class PurchaseListTile extends StatelessWidget {
  final PurchaseList purchaseList;
  final VoidCallback? onPressed;

  const PurchaseListTile({
    Key? key,
    required this.purchaseList,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconListItem(
      title: purchaseList.name,
      subtitle2: _getTotal(),
      onPressed: onPressed,
      iconColor: context.theme.colors.greyAccent,
      icon: BaratitoIcons.buy,
      actionIcon: BaratitoIcons.arrowRight,
    );
  }

  String _getTotal() {
    var value = 0.0;
    for (final establishment in purchaseList.establishments) {
      final prices = establishment.items.map<double>((item) {
        if (item.isBought) return item.price;
        return 0;
      });
      value += prices.sum;
    }
    return '\$${value.toStringAsFixed(2)}';
  }
}
