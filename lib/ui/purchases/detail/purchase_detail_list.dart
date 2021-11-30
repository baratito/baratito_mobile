import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/purchases/detail/marker_colors_utils.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

typedef OnItemPressed = void Function(PurchaseListItem item);

class PurchaseDetailList extends StatelessWidget {
  final PurchaseList purchaseList;
  final OnItemPressed? onItemPressed;

  const PurchaseDetailList({
    Key? key,
    required this.purchaseList,
    this.onItemPressed,
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
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: _Indicator(isSelected: item.isBought, color: color),
          ),
          Expanded(
            child: ListItemBase(
              title: item.name,
              subtitle1: '${item.quantity} unidades',
              subtitle2: '\$${item.price.toInt()}',
              subtitle2Color: context.theme.colors.greenAccent,
              onPressed: () => onItemPressed?.call(item),
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final bool isSelected;
  final Color? color;

  const _Indicator({
    Key? key,
    this.color,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = color ?? context.theme.colors.primary;
    if (isSelected) return _buildSelectedIndicator(context, _color);
    return _buildNotSelectedIndicator(context, _color);
  }

  Widget _buildNotSelectedIndicator(BuildContext context, Color color) {
    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.only(right: context.responsive(16)),
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: color),
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSelectedIndicator(BuildContext context, Color color) {
    return Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.only(right: context.responsive(16)),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, size: 16, color: Colors.white),
    );
  }
}
