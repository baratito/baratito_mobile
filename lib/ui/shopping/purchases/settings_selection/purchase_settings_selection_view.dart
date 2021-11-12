import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/shopping/purchases/settings_selection/establishments_distance_button.dart';
import 'package:baratito_mobile/ui/shopping/purchases/settings_selection/max_establishments_button.dart';
import 'package:baratito_mobile/ui/shopping/purchases/settings_selection/mobility_mode_button.dart';
import 'package:baratito_mobile/ui/shopping/purchases/settings_selection/purchase_view.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/ui/shared/bottom_bars/bottom_bars.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class PurchaseSettingsSelectionView extends StatelessWidget {
  final PurchaseCubit purchaseCubit;

  const PurchaseSettingsSelectionView({
    Key? key,
    required this.purchaseCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View(
      appBar: MainAppBar(
        title: 'purchases.plan'.tr(),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return BlocConsumer<PurchaseCubit, PurchaseState>(
      bloc: purchaseCubit,
      listener: (context, state) {
        if (state is PurchaseLoaded) {
          _navigateToPurchase(context);
        }
      },
      builder: (context, state) {
        if (state is! PurchaseSettingsData) return Container();
        final settings = state.purchaseSettings;
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(padding, 16, padding, 0),
              child: Column(
                children: [
                  _buildLabel(context, 'purchases.max_market_count'.tr()),
                  Padding(
                    padding: EdgeInsets.only(top: context.responsive(12)),
                    child: _buildMaxMarketCountButtons(context, settings),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: context.responsive(32)),
                    child: _buildLabel(
                        context, 'purchases.max_market_distance'.tr()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: context.responsive(12)),
                    child: _buildMaxMarketDistanceButtons(context, settings),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: context.responsive(32)),
                    child: _buildLabel(context, 'purchases.mobility_mode'.tr()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: context.responsive(12)),
                    child: _buildMobilityModeButtons(context, settings),
                  ),
                ],
              ),
            ),
            const Spacer(),
            _buildButtonBar(context),
          ],
        );
      },
    );
  }

  Widget _buildMaxMarketCountButtons(
    BuildContext context,
    PurchaseSettings settings,
  ) {
    return Row(
      children: [
        for (final index in Iterable.generate(4))
          _buildMaxMarketCountButton(context, index, settings),
      ],
    );
  }

  Widget _buildMaxMarketCountButton(
    BuildContext context,
    int index,
    PurchaseSettings settings,
  ) {
    final number = index + 1;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: MaxEstablishmentsButton(
        number: number,
        onPressed: () {
          purchaseCubit.updateSettings(maxMarketCount: number);
        },
        isSelected: number == settings.maxMarketCount,
      ),
    );
  }

  Widget _buildMaxMarketDistanceButtons(
    BuildContext context,
    PurchaseSettings settings,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final marketDistance in MarketDistance.values)
            _buildMaxMarketDistanceButton(context, marketDistance, settings),
        ],
      ),
    );
  }

  Widget _buildMaxMarketDistanceButton(
    BuildContext context,
    MarketDistance marketDistance,
    PurchaseSettings settings,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: EstablishmentsDistanceButton(
        label: 'purchases.${marketDistance.toString().split(".").last}'.tr(),
        onPressed: () {
          purchaseCubit.updateSettings(maxMarketDistance: marketDistance);
        },
        isSelected: marketDistance == settings.maxMarketDistance,
      ),
    );
  }

  Widget _buildMobilityModeButtons(
    BuildContext context,
    PurchaseSettings settings,
  ) {
    return Row(
      children: [
        for (final mobilityMode in MobilityMode.values)
          _buildMobilityModeButton(context, mobilityMode, settings),
      ],
    );
  }

  Widget _buildMobilityModeButton(
    BuildContext context,
    MobilityMode mobilityMode,
    PurchaseSettings settings,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: MobilityModeButton(
        icon: _getMobilityModeIcon(mobilityMode),
        onPressed: () {
          purchaseCubit.updateSettings(mobilityMode: mobilityMode);
        },
        isSelected: mobilityMode == settings.mobilityMode,
      ),
    );
  }

  IconData _getMobilityModeIcon(MobilityMode mobilityMode) {
    switch (mobilityMode) {
      case MobilityMode.driving:
        return Icons.drive_eta_rounded;
      case MobilityMode.walking:
        return Icons.person_outline_rounded;
      case MobilityMode.bicycle:
        return Icons.pedal_bike;
    }
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Row(
      children: [
        Flexible(
          child: Text(text, style: context.theme.text.label),
        )
      ],
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return ExtendedButtonBottomBar(
      label: 'shopping.start'.tr(),
      onPressed: () => purchaseCubit.startPurchase(),
    );
  }

  void _navigateToPurchase(BuildContext context) {
    context.pushView(PurchaseView(purchaseCubit: purchaseCubit));
  }
}
