import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/purchases/detail/purchase_detail_view.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class PurchaseDetailLoadingView extends StatelessWidget {
  final PurchaseCubit purchaseCubit;

  const PurchaseDetailLoadingView({
    Key? key,
    required this.purchaseCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return BlocListener<PurchaseCubit, PurchaseState>(
      bloc: purchaseCubit,
      listener: (context, state) async {
        if (state is PurchaseLoaded) {
          _navigateToPurchase(context);
        } else if (state is PurchaseFailed) {
          final failure = state.failure;
          await showFailureDialog(context: context, failure: failure);
          context.popView();
        }
      },
      child: View(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoriesLoadingIndicator(size: context.responsive(60)),
              Padding(
                padding: EdgeInsets.only(top: context.responsive(24)),
                child: _buildText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            'purchases.loading'.tr(),
            style: context.theme.text.body,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  void _navigateToPurchase(BuildContext context) {
    context.pushReplacementView(
      PurchaseDetailView(purchaseCubit: purchaseCubit),
      RouteTransitionType.fade,
    );
  }
}
