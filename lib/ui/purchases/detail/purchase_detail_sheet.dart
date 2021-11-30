import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/purchases/detail/purchase_detail_information.dart';
import 'package:baratito_mobile/ui/purchases/detail/purchase_detail_list.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class PurchaseDetailSheet extends StatelessWidget {
  final PurchaseCubit purchaseCubit;
  final PanelController panelController;
  final bool isOpen;

  const PurchaseDetailSheet({
    Key? key,
    required this.purchaseCubit,
    required this.panelController,
    this.isOpen = false,
  }) : super(key: key);

  void _openPanel() => panelController.open();

  void _closePanel() => panelController.close();

  @override
  Widget build(BuildContext context) {
    final dimensions = context.theme.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensions.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return BottomSheetBase(
      showDragLine: false,
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      bloc: purchaseCubit,
      builder: (context, state) {
        if (state is! PurchaseData) return Container();
        final purchaseList = state.purchaseList;
        return AnimatedCrossFade(
          firstChild: _buildInformation(context, purchaseList),
          secondChild: _buildList(context, purchaseList),
          crossFadeState:
              isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, PurchaseList purchaseList) {
    if (!isOpen) return Container();
    return FadeIn(
      child: Column(
        children: [
          _buildCloseButton(context),
          Expanded(
            child: PurchaseDetailList(
              purchaseList: purchaseList,
              onItemPressed: (item) {
                purchaseCubit.toggleItemBoughtState(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconActionButton(
            icon: Icons.keyboard_arrow_down_rounded,
            onTap: _closePanel,
          )
        ],
      ),
    );
  }

  Widget _buildInformation(BuildContext context, PurchaseList purchaseList) {
    return FadeIn(
      child: Padding(
        padding: EdgeInsets.only(top: context.responsive(8)),
        child: Column(
          children: [
            _buildTabs(context),
            PurchaseDetailInformation(purchaseList: purchaseList),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Tab(
          label: 'purchases.information'.tr(),
          isActive: true,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: context.responsive(32, axis: Axis.horizontal),
          ),
          child: _Tab(
            label: 'shopping.shopping_list'.tr(),
            isActive: false,
            onPressed: _openPanel,
          ),
        ),
      ],
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onPressed;

  const _Tab({
    Key? key,
    required this.label,
    this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color =
        isActive ? null : context.theme.colors.greyAccent.withOpacity(.6);
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            label,
            style: context.theme.text.body.copyWith(color: color),
          ),
          if (isActive)
            Padding(
              padding: EdgeInsets.only(top: context.responsive(4)),
              child: Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: context.theme.colors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            )
        ],
      ),
    );
  }
}
