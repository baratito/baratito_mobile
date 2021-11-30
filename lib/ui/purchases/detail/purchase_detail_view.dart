import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/ui/purchases/detail/purchase_detail_map.dart';
import 'package:baratito_mobile/ui/purchases/detail/purchase_detail_sheet.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PurchaseDetailView extends StatefulWidget {
  final PurchaseCubit purchaseCubit;

  const PurchaseDetailView({
    Key? key,
    required this.purchaseCubit,
  }) : super(key: key);

  @override
  State<PurchaseDetailView> createState() => _PurchaseDetailViewState();
}

class _PurchaseDetailViewState extends State<PurchaseDetailView> {
  final _panelController = PanelController();
  bool _isPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    final maxHeight = context.screenSize.height * .88;
    final minHeight = context.screenSize.height / 3.2;
    return View(
      child: SlidingUpPanel(
        controller: _panelController,
        maxHeight: maxHeight,
        minHeight: minHeight,
        renderPanelSheet: false,
        backdropTapClosesPanel: false,
        panelSnapping: false,
        isDraggable: false,
        onPanelOpened: () => setState(() => _isPanelOpen = true),
        onPanelClosed: () => setState(() => _isPanelOpen = false),
        panel: _buildBottomSheet(),
        body: Stack(
          children: [
            _buildContent(),
            _buildBackButton(),
            _buildCompleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return PurchaseDetailSheet(
      panelController: _panelController,
      purchaseCubit: widget.purchaseCubit,
      isOpen: _isPanelOpen,
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: context.responsive(12),
          top: context.responsive(12),
        ),
        child: const _BackButton(),
      ),
    );
  }

  Widget _buildCompleteButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: context.responsive(12),
          top: context.responsive(12),
        ),
        child: BlocBuilder<PurchaseCubit, PurchaseState>(
          bloc: widget.purchaseCubit,
          builder: (context, state) {
            return _CompleteButton(
              isLoading: state is PurchaseCompleting,
              onPressed: () => widget.purchaseCubit.completePurchase(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<PurchaseCubit, PurchaseState>(
      bloc: widget.purchaseCubit,
      listener: (context, state) async {
        if (state is PurchaseCompleted) {
          for (final _ in Iterable.generate(2)) {
            await context.popView();
          }
        }
      },
      builder: (context, state) {
        if (state is! PurchaseData) return Container();
        final purchaseList = state.purchaseList;
        return _buildMap(purchaseList);
      },
    );
  }

  Widget _buildMap(PurchaseList purchaseList) {
    return PurchaseDetailMap(purchaseList: purchaseList);
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colors.iconAction;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.theme.colors.background,
        boxShadow: [context.theme.shadows.small],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          highlightColor: color.withOpacity(.2),
          splashColor: color.withOpacity(.05),
          onTap: context.popView,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              context.isIos ? Icons.arrow_back_ios_new : Icons.arrow_back,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class _CompleteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  const _CompleteButton({
    Key? key,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colors.iconAction;
    final radius = BorderRadius.circular(16);
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: context.theme.colors.primary,
        boxShadow: [context.theme.shadows.small],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          highlightColor: color.withOpacity(.2),
          splashColor: color.withOpacity(.05),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsive(12, axis: Axis.horizontal),
              vertical: context.responsive(10),
            ),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          Padding(
            padding: EdgeInsets.only(
              right: context.responsive(4, axis: Axis.horizontal),
            ),
            child: const Spinner(size: 14),
          ),
        if (!isLoading) _buildIcon(context),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              left: context.responsive(4, axis: Axis.horizontal),
            ),
            child: Text(
              'purchases.complete'.tr(),
              style: context.theme.text.primaryButton,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    final theme = context.theme.text.primaryButton;
    return Icon(
      Icons.check,
      size: 18,
      color: theme.color,
    );
  }
}
