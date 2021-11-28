import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class ProductDetailMinimumPrice extends StatelessWidget {
  final bool isLoading;
  final Price? price;

  const ProductDetailMinimumPrice({
    Key? key,
    this.price,
    this.isLoading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading && price == null) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingCrossfade(
          isLoading: isLoading,
          loadingWidget: _buildSkeleton(context),
          child: _buildContent(context),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (price == null) return Container();
    return Column(
      children: [
        Text(
          '\$${_getValueString(price!)}',
          style: context.theme.text.title.copyWith(
            color: context.theme.colors.greenAccent,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: context.responsive(12)),
          child: Text(
            'market.minimum_price'.tr(),
            style: context.theme.text.label,
          ),
        )
      ],
    );
  }

  String _getValueString(Price price) {
    final value = price.value;
    if (value % 1 == 0) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(2);
  }

  Widget _buildSkeleton(BuildContext context) {
    return Column(
      children: [
        PulseBox(
          height: 28,
          width: 68,
          margin: EdgeInsets.only(top: context.responsive(12)),
        ),
        PulseBox(
          height: 18,
          width: 100,
          margin: EdgeInsets.only(
            top: context.responsive(16),
            bottom: context.responsive(8),
          ),
        ),
      ],
    );
  }
}
