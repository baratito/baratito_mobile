import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class PurchaseDetailInformation extends StatelessWidget {
  final PurchaseList purchaseList;

  const PurchaseDetailInformation({
    Key? key,
    required this.purchaseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.responsive(16)),
            child: _buildEllipsisTitle(context, purchaseList),
          ),
          _buildValue(context, purchaseList),
          Padding(
            padding: EdgeInsets.only(top: context.responsive(8)),
            child: _buildDistance(context, purchaseList),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.responsive(8)),
            child: _buildDuration(context, purchaseList),
          ),
        ],
      ),
    );
  }

  Widget _buildEllipsisTitle(BuildContext context, PurchaseList purchaseList) {
    return Row(
      children: [
        Flexible(
          child: TextOneLine(
            purchaseList.name,
            overflow: TextOverflow.fade,
            style: context.theme.text.headline1,
          ),
        ),
      ],
    );
  }

  Widget _buildValue(BuildContext context, PurchaseList purchaseList) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text.rich(
            TextSpan(
              text: _getPurchaseListValue(purchaseList),
              style: context.theme.text.title.copyWith(
                color: context.theme.colors.greenAccent,
              ),
              children: [
                TextSpan(text: ' est.', style: context.theme.text.body),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getPurchaseListValue(PurchaseList purchaseList) {
    return '\$${purchaseList.estimatedValue.toStringAsFixed(2)}';
  }

  Widget _buildDistance(BuildContext context, PurchaseList purchaseList) {
    return Row(
      children: [
        Icon(
          Icons.drive_eta_rounded,
          color: context.theme.colors.greyAccent,
          size: 20,
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: context.responsive(8, axis: Axis.horizontal),
            ),
            child: Text(
              _getDistance(purchaseList),
              style: context.theme.text.body,
            ),
          ),
        ),
      ],
    );
  }

  String _getDistance(PurchaseList purchaseList) {
    final distanceInKm = purchaseList.totalDistanceInMeters / 1000;
    final label = 'purchases.distance_to_travel'.tr();
    return '${distanceInKm.toStringAsFixed(1)} $label';
  }

  Widget _buildDuration(BuildContext context, PurchaseList purchaseList) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: context.theme.colors.greyAccent,
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            _getDuration(purchaseList),
            style: context.theme.text.body,
          ),
        ),
      ],
    );
  }

  String _getDuration(PurchaseList purchaseList) {
    final durationInMinutes = purchaseList.duration.inMinutes;
    final label = 'purchases.duration_label'.tr();
    return '$durationInMinutes $label';
  }
}
