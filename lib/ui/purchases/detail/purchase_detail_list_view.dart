import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/extensions/responsive_extension.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class PurchaseDetailListView extends StatelessWidget {
  final PurchaseList purchaseList;

  const PurchaseDetailListView({
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
          context.responsive(16),
          padding,
          0,
        ),
        child: Expanded(
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final count = purchaseList.establishments.length;
    return ListView.builder(
      itemBuilder: _buildEstablishment,
      itemCount: count,
    );
  }

  Widget _buildEstablishment(BuildContext context, int index) {
    final establishment = purchaseList.establishments[index];
    final count = establishment.items.length + 1;
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(32)),
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
          return _buildProductItem(context, item);
        },
      ),
    );
  }

  Widget _buildEstablishmentItem(
    BuildContext context,
    Establishment establishment,
  ) {
    final text = establishment.brand.isNotEmpty
        ? establishment.brand
        : establishment.name;
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  text,
                  style: context.theme.text.title,
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  establishment.address,
                  style: context.theme.text.headline2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    PurchaseListItem item,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(40)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.only(right: context.responsive(16)),
            decoration: BoxDecoration(
              border: Border.all(width: 4, color: context.theme.colors.primary),
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
