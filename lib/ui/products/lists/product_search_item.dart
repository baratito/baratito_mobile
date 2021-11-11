import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class ProductSearchItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onPressed;

  const ProductSearchItem({
    Key? key,
    required this.product,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItemBase(
      title: product.name,
      subtitle1: product.category.getLocalizationKey().tr(),
      onPressed: onPressed,
      leading: _buildLeading(context),
    );
  }

  Widget _buildLeading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: context.responsive(16, axis: Axis.horizontal),
      ),
      child: NetworkImageSquircle(
        imageUrl: product.imageUrl,
        fallbackWidget: const IconSquircle(icon: BaratitoIcons.bag),
        loadingWidget: const IconSquircle(icon: BaratitoIcons.bag),
      ),
    );
  }
}
