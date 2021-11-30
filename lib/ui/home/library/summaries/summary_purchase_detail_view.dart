import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/purchases/purchases.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class SummaryPurchaseDetailView extends StatelessWidget {
  final PurchaseList purchaseList;

  const SummaryPurchaseDetailView({
    Key? key,
    required this.purchaseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return View(
      appBar: const MainAppBar(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          padding,
          context.responsive(12),
          padding,
          0,
        ),
        child: Column(
          children: [
            _buildTitle(context),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: context.responsive(24)),
                child: _buildList(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            purchaseList.name,
            style: context.theme.text.headline1,
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return PurchaseDetailList(purchaseList: purchaseList);
  }
}
