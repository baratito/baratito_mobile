import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/bottom_bars/bottom_bar_base.dart';
import 'package:baratito_mobile/extensions/extensions.dart';

class ProductsCountButtonBottomBar extends StatelessWidget {
  final int count;
  final bool? isLoading;
  final VoidCallback? onPressed;

  const ProductsCountButtonBottomBar({
    Key? key,
    required this.count,
    this.onPressed,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomBarBase(
      elevated: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsive(24, axis: Axis.horizontal),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [..._buildItems(context)],
        ),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return [
      SizedBox(
        height: 56,
        child: SolidButtonBase.extended(
          label: 'shopping.selected_products'.tr(),
          leading: Padding(
            padding: EdgeInsets.only(
              right: context.responsive(8, axis: Axis.horizontal),
            ),
            child: _buildLeading(context),
          ),
          onTap: onPressed,
        ),
      ),
    ];
  }

  Widget _buildLeading(BuildContext context) {
    if (isLoading ?? false) return const Spinner();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: context.theme.text.primaryButton.color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$count',
        style: context.theme.text.primaryButton.copyWith(
          color: context.theme.colors.primary,
        ),
      ),
    );
  }
}
