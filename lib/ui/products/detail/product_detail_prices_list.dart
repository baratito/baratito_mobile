import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/products/lists/lists.dart';
import 'package:baratito_mobile/extensions/extensions.dart';

class ProductDetailPricesList extends StatelessWidget {
  final bool isLoading;
  final List<Price>? prices;

  const ProductDetailPricesList({
    Key? key,
    this.prices,
    this.isLoading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading && prices == null) return Container();
    if (prices != null && prices!.isEmpty) return Container();
    return LoadingCrossfade(
      isLoading: isLoading,
      loadingWidget: _buildSkeleton(context),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (prices == null) return Container();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: context.responsive(20)),
          child: Text(
            'market.establishments'.tr(),
            style: context.theme.text.label,
          ),
        ),
        for (final index in Iterable.generate(prices!.length))
          Padding(
            padding: EdgeInsets.only(bottom: context.responsive(12)),
            child: PriceItem(
              price: prices![index],
              color: index == 0 ? context.theme.colors.greenAccent : null,
            ),
          )
      ],
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PulseBox(
          height: 18,
          width: 120,
          margin: EdgeInsets.only(top: context.responsive(12)),
        ),
        SizedBox(height: context.responsive(8)),
        for (final _ in Iterable.generate(4))
          Padding(
            padding: EdgeInsets.only(top: context.responsive(16)),
            child: Row(
              children: [
                PulseBox.square(
                  dimension: context.theme.dimensions.squircleContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: context.responsive(12, axis: Axis.horizontal),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PulseBox(height: 16, width: 160),
                      PulseBox(
                        height: 14,
                        width: 80,
                        margin: EdgeInsets.only(top: context.responsive(12)),
                      ),
                      PulseBox(
                        height: 14,
                        width: 60,
                        margin: EdgeInsets.only(top: context.responsive(12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
