import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:baratito_mobile/configs/configs.dart';

class ShoppingListItemsEmptyIllustration extends StatelessWidget {
  const ShoppingListItemsEmptyIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkmodeActive = context.isDarkmodeActive;
    final illustration = isDarkmodeActive
        ? Illustrations.shoppingListItemsEmptyDark
        : Illustrations.shoppingListItemsEmptyLight;
    return SvgPicture.asset(illustration, width: 200);
  }
}
