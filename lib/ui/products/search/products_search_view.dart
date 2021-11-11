import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/ui/products/detail/detail.dart';
import 'package:baratito_mobile/ui/products/lists/lists.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/products/search/categories_list.dart';
import 'package:baratito_mobile/ui/products/search/no_results_illustration.dart';
import 'package:baratito_mobile/ui/products/search/selected_category.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class ProductsSearchView extends StatefulWidget {
  final ProductsSearchCubit productsSearchCubit;

  const ProductsSearchView({
    Key? key,
    required this.productsSearchCubit,
  }) : super(key: key);

  @override
  State<ProductsSearchView> createState() => _ProductsSearchViewState();
}

class _ProductsSearchViewState extends State<ProductsSearchView> {
  @override
  Widget build(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );

    return View(
      appBar: MainAppBar(
        title: 'products.search_title'.tr(),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          padding,
          context.responsive(16),
          padding,
          0,
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildSearchInput(context),
        BlocConsumer<ProductsSearchCubit, ProductsSearchState>(
          bloc: widget.productsSearchCubit,
          listener: (context, state) {
            if (state is ProductsSearchFailed) {
              showFailureDialog(context: context, failure: state.failure);
            }
          },
          builder: (context, state) {
            final showSelectedCategory =
                state is ProductsSearchQueryState && state.category != null;
            return Expanded(
              child: Column(
                children: [
                  if (showSelectedCategory)
                    _buildSelectedCategory(
                      context,
                      state as ProductsSearchQueryState,
                    ),
                  Expanded(child: _buildResults(context, state)),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildSearchInput(BuildContext context) {
    return RoundedInput.large(
      placeholder: 'products.search_placeholder'.tr(),
      autofocus: true,
      onValueChanged: _onSearchTextChanged,
    );
  }

  void _onSearchTextChanged(String value) {
    Debounce.milliseconds(400, widget.productsSearchCubit.setQuery, [], {
      const Symbol('query'): value,
    });
  }

  Widget _buildSelectedCategory(
    BuildContext context,
    ProductsSearchQueryState state,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.responsive(16),
        bottom: context.responsive(8),
      ),
      child: SelectedCategory(
        category: state.category!,
        onUnselectPressed: () => _onUnselectButtonPressed(),
      ),
    );
  }

  void _onUnselectButtonPressed() {
    widget.productsSearchCubit.setCategory(category: null);
  }

  Widget _buildResults(BuildContext context, ProductsSearchState state) {
    if (state is ProductsSearchInitial) {
      return _buildCategoriesList(context);
    }

    if (state is ProductsSearchLoading) {
      return _buildLoading(context);
    }

    if (state is ProductsSearchNoResults) {
      return _buildNoResults(context);
    }

    if (state is ProductsSearchResultsFound) {
      return _buildProductsList(context, state);
    }

    return Container();
  }

  Widget _buildCategoriesList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.responsive(20)),
      child: CategoriesList(
        onCategoryPressed: _onCategoryButtonPressed,
      ),
    );
  }

  void _onCategoryButtonPressed(Category category) {
    widget.productsSearchCubit.setCategory(category: category);
  }

  Widget _buildLoading(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Spinner()],
    );
  }

  Widget _buildNoResults(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const NoResultsIllustration(),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(24)),
          child: Text(
            'products.search_no_results'.tr(),
            style: context.theme.text.body,
          ),
        ),
      ],
    );
  }

  Widget _buildProductsList(
    BuildContext context,
    ProductsSearchResultsFound state,
  ) {
    final products = state.products;
    final hasNext = state is ProductsSearchResultsNextPageAvailable;
    return ProductsSearchList(
      hasNext: hasNext,
      items: products,
      onScrollEndReached: () => widget.productsSearchCubit.getNextPage(),
      onProductPressed: _openDetail,
    );
  }

  void _openDetail(Product product) {
    final productDetailCubit = getDependency<ProductDetailCubit>();
    productDetailCubit.load(product: product);
    context.pushView(ProductDetailView(
      productDetailCubit: productDetailCubit,
    ));
  }
}
