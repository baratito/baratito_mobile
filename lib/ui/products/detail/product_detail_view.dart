import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/products/lists/lists.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class ProductDetailView extends StatelessWidget {
  final ProductDetailCubit productDetailCubit;

  const ProductDetailView({
    Key? key,
    required this.productDetailCubit,
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
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<ProductDetailCubit, ProductDetailState>(
      bloc: productDetailCubit,
      listener: (context, state) {
        if (state is ProductDetailLoadFailed) {
          final failure = state.failure;
          showFailureDialog(context: context, failure: failure);
        }
      },
      builder: (context, state) {
        if (state is ProductDetailData) {
          return _buildDetail(context, state);
        }
        return Container();
      },
    );
  }

  Widget _buildDetail(BuildContext context, ProductDetailData state) {
    final isLoading = state is! ProductDetailLoadSucceded;
    final product = state.product;
    return ListView(
      children: [
        _ProductTitle(product: product),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(32)),
          child: _buildImage(context, product),
        ),
        if (!isLoading)
          Padding(
            padding: EdgeInsets.only(top: context.responsive(24)),
            child: _buildMinimumPrice(
              context,
              state as ProductDetailLoadSucceded,
            ),
          ),
        if (!isLoading)
          Padding(
            padding: EdgeInsets.only(top: context.responsive(16)),
            child: _buildPrices(context, state as ProductDetailLoadSucceded),
          ),
      ],
    );
  }

  Widget _buildImage(BuildContext context, Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NetworkImageSquircle(
          imageUrl: product.imageUrl,
          fallbackWidget: const IconSquircle(icon: BaratitoIcons.bag),
          loadingWidget: const IconSquircle(icon: BaratitoIcons.bag),
          size: context.screenSize.width / 2,
        ),
      ],
    );
  }

  Widget _buildMinimumPrice(
      BuildContext context, ProductDetailLoadSucceded state) {
    final minimumPrice = state.prices.first;
    return Column(
      children: [
        Text(
          '\$${_getValueString(minimumPrice)}',
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

  Widget _buildPrices(BuildContext context, ProductDetailLoadSucceded state) {
    final prices = state.prices;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: context.responsive(20)),
          child: Text(
            'market.establishments'.tr(),
            style: context.theme.text.label,
          ),
        ),
        for (final i in Iterable.generate(prices.length))
          Padding(
            padding: EdgeInsets.only(bottom: context.responsive(12)),
            child: PriceItem(
              price: prices[i],
              color: i == 0 ? context.theme.colors.greenAccent : null,
            ),
          )
      ],
    );
  }
}

class _ProductTitle extends StatelessWidget {
  final Product product;

  const _ProductTitle({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                product.name,
                style: context.theme.text.headline1,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(4)),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  product.presentation,
                  style: context.theme.text.body,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
