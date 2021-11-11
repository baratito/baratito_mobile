import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {
  final Price price;
  final VoidCallback? onPressed;
  final Color? color;

  const PriceItem({
    Key? key,
    required this.price,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconListItem(
      title: price.establishment.brand,
      subtitle1: price.establishment.name,
      subtitle2: '\$${_getValueString()}',
      subtitle2Color: color ?? context.theme.colors.greyAccent,
      iconColor: color ?? context.theme.colors.greyAccent,
      onPressed: onPressed,
      icon: BaratitoIcons.bag,
    );
  }

  String _getValueString() {
    final value = price.value;
    if (value % 1 == 0) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(2);
  }
}
