import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/ui/products/detail/product_detail_title.dart';
import 'package:baratito_mobile/ui/products/detail/product_detail_minimum_price.dart';
import 'package:baratito_mobile/ui/products/detail/product_detail_prices_list.dart';
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
    final product = state.product;
    return ListView(
      children: [
        ProductDetailTitle(product: product),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(32)),
          child: _buildImage(context, product),
        ),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(24)),
          child: _buildMinimumPrice(context, state),
        ),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(16)),
          child: _buildPrices(context, state),
        ),
      ],
    );
  }

  Widget _buildMinimumPrice(BuildContext context, ProductDetailData state) {
    final isLoading = state is! ProductDetailLoadSucceded;
    Price? minimumPrice;
    if (!isLoading) {
      final _state = state as ProductDetailLoadSucceded;
      final prices = _state.prices;
      if (prices.isNotEmpty) minimumPrice = prices.first;
    }
    return ProductDetailMinimumPrice(isLoading: isLoading, price: minimumPrice);
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

  Widget _buildPrices(BuildContext context, ProductDetailData state) {
    final isLoading = state is! ProductDetailLoadSucceded;
    final prices =
        isLoading ? null : (state as ProductDetailLoadSucceded).prices;
    return ProductDetailPricesList(isLoading: isLoading, prices: prices);
  }
}
