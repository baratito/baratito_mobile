import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

// If categories start changing, we should remove this ugliness and
// refactor Category into a proper entity intead of an enum in the core lib.
extension CategoryExtension on Category {
  Color getColor(BuildContext context) {
    final colors = context.theme.colors;
    switch (this) {
      case Category.none:
        return const Color(0x00000000);
      case Category.frozenFood:
        return colors.blueAccent;
      case Category.personalCare:
        return colors.lilacAccent;
      case Category.nonAlcoholicBeverages:
        return colors.aquamarineAccent;
      case Category.alcoholicBeverages:
        return colors.mauveAccent;
      case Category.babyProducts:
        return colors.pinkAccent;
      case Category.petProducts:
        return colors.brownAccent;
      case Category.freshFood:
        return colors.salmonAccent;
      case Category.cleaningProducts:
        return colors.lightblueAccent;
      case Category.groceryProducts:
        return colors.orangeAccent;
    }
  }

  IconData getIcon() {
    switch (this) {
      case Category.none:
        return const IconData(0);
      case Category.frozenFood:
        return BaratitoIcons.snowflake;
      case Category.personalCare:
        return BaratitoIcons.toothbrush;
      case Category.nonAlcoholicBeverages:
        return BaratitoIcons.bottle;
      case Category.alcoholicBeverages:
        return BaratitoIcons.wine;
      case Category.babyProducts:
        return BaratitoIcons.baby;
      case Category.petProducts:
        return BaratitoIcons.treat;
      case Category.freshFood:
        return BaratitoIcons.steak;
      case Category.cleaningProducts:
        return BaratitoIcons.bubbles;
      case Category.groceryProducts:
        return BaratitoIcons.can;
    }
  }

  String getLocalizationKey() {
    const baseKey = 'products.categories';
    switch (this) {
      case Category.none:
        return '$baseKey.other';
      case Category.frozenFood:
        return '$baseKey.frozen_food';
      case Category.personalCare:
        return '$baseKey.personal_care';
      case Category.nonAlcoholicBeverages:
        return '$baseKey.non_alcoholic_beverages';
      case Category.alcoholicBeverages:
        return '$baseKey.alcoholic_beverages';
      case Category.babyProducts:
        return '$baseKey.baby_products';
      case Category.petProducts:
        return '$baseKey.pet_products';
      case Category.freshFood:
        return '$baseKey.fresh_food';
      case Category.cleaningProducts:
        return '$baseKey.cleaning_products';
      case Category.groceryProducts:
        return '$baseKey.grocery_products';
    }
  }
}
