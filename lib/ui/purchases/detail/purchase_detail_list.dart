import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/purchases/detail/marker_colors_utils.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class PurchaseDetailList extends StatelessWidget {
  final PurchaseList purchaseList;

  const PurchaseDetailList({
    Key? key,
    required this.purchaseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = getMarkerColors(context);
    final establishments = purchaseList.establishments;
    return ListView(
      children: [
        for (final index in Iterable.generate(establishments.length))
          _buildEstablishment(context, establishments[index], colors[index]),
      ],
    );
  }

  Widget _buildEstablishment(
    BuildContext context,
    PurchaseListItemEstablishment establishment,
    Color color,
  ) {
    final count = establishment.items.length + 1;
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(16)),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (_, i) {
          if (i == 0) {
            final e = establishment.establishment;
            return _buildEstablishmentItem(context, e);
          }
          final item = establishment.items[i - 1];
          return _buildProductItem(context, item, color);
        },
      ),
    );
  }

  Widget _buildEstablishmentItem(
    BuildContext context,
    Establishment establishment,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(context, establishment),
          _buildAddress(context, establishment),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Establishment establishment) {
    final title = establishment.brand.isNotEmpty
        ? establishment.brand
        : establishment.name;
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: context.theme.text.headline1,
          ),
        )
      ],
    );
  }

  Widget _buildAddress(BuildContext context, Establishment establishment) {
    return Row(
      children: [
        Flexible(
          child: Text(
            establishment.address,
            style: context.theme.text.body,
          ),
        )
      ],
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    PurchaseListItem item,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.only(right: context.responsive(16)),
            decoration: BoxDecoration(
              border: Border.all(width: 4, color: color),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: ListItemBase(
              title: item.name,
              subtitle1: '${item.quantity} unidades',
              subtitle2: '\$${item.price.toInt()}',
              subtitle2Color: context.theme.colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}
