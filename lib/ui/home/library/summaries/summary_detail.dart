import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/home/library/summaries/purchase_list_tile.dart';
import 'package:baratito_mobile/ui/home/library/summaries/summary_purchase_detail_view.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class SummaryDetail extends StatelessWidget {
  final MonthlyPurchaseSummary summary;

  const SummaryDetail({
    Key? key,
    required this.summary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.responsive(24)),
          child: _buildTotal(context),
        ),
        Expanded(child: _buildPurchases()),
      ],
    );
  }

  Widget _buildTotal(BuildContext context) {
    final theme = context.theme.text.title.copyWith(
      color: context.theme.colors.greenAccent,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_getTotal(), style: theme),
        Text('purchases.spent'.tr(), style: context.theme.text.label),
      ],
    );
  }

  String _getTotal() {
    final total = summary.total;
    return '\$${total.toStringAsFixed(2)}';
  }

  Widget _buildPurchases() {
    return ListView.builder(
      itemCount: summary.purchases.length,
      itemBuilder: _buildPurchaseItem,
    );
  }

  Widget _buildPurchaseItem(BuildContext context, int index) {
    final purchaseList = summary.purchases[index];
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(12)),
      child: PurchaseListTile(
        purchaseList: purchaseList,
        onPressed: () {
          context.pushView(
            SummaryPurchaseDetailView(purchaseList: purchaseList),
          );
        },
      ),
    );
  }
}
