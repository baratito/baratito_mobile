import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/shopping/purchases/settings_selection/purchase_list_view.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:baratito_mobile/ui/shared/bottom_bars/bottom_bars.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class PurchaseView extends StatelessWidget {
  final PurchaseCubit purchaseCubit;

  const PurchaseView({
    Key? key,
    required this.purchaseCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View(
      appBar: MainAppBar(
        title: 'purchases.in_progress'.tr(),
        actions: [
          _buildAction(context),
        ],
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildAction(BuildContext context) {
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      bloc: purchaseCubit,
      builder: (context, state) {
        if (state is! PurchaseLoaded) return Container();
        final purchaseList = state.purchaseList;
        return IconActionButton(
          icon: Icons.list,
          onTap: () => _openList(context, purchaseList),
          iconSize: 26,
        );
      },
    );
  }

  void _openList(BuildContext context, PurchaseList purchaseList) {
    context.pushView(PurchaseListView(purchaseList: purchaseList));
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      bloc: purchaseCubit,
      builder: (context, state) {
        if (state is! PurchaseLoaded) return Container();
        final purchaseList = state.purchaseList;
        return Column(
          children: [
            Expanded(child: _buildMap(context, purchaseList)),
            _buildInformationBox(context, purchaseList),
            _buildButtonBar(context),
          ],
        );
      },
    );
  }

  Widget _buildMap(BuildContext context, PurchaseList purchaseList) {
    final firstEstablishmentLocation =
        purchaseList.establishments.first.establishment.location;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: GoogleMap(
        markers: {
          for (final e in purchaseList.establishments)
            Marker(
              markerId: MarkerId(e.establishment.id.toString()),
              position: LatLng(
                e.establishment.location.latitude,
                e.establishment.location.longitude,
              ),
            )
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            firstEstablishmentLocation.latitude,
            firstEstablishmentLocation.longitude,
          ),
          zoom: 14,
        ),
      ),
    );
  }

  Widget _buildInformationBox(BuildContext context, PurchaseList purchaseList) {
    return Container(
      color: context.theme.colors.background,
      padding: EdgeInsets.symmetric(
        vertical: context.responsive(32),
        horizontal: context.responsive(32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(purchaseList.name, style: context.theme.text.headline1),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.responsive(12)),
                child: Text(
                  '\$${purchaseList.estimatedValue.toStringAsFixed(2)}',
                  style: context.theme.text.title.copyWith(
                    color: context.theme.colors.greenAccent,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.drive_eta_rounded,
                  color: context.theme.colors.greyAccent,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '${(purchaseList.totalDistanceInMeters / 1000).toStringAsFixed(1)}Km por recorrer',
                    style: context.theme.text.body,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: context.theme.colors.greyAccent,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '${purchaseList.duration.inMinutes} minutos',
                    style: context.theme.text.body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return DoubleButtonBottomBar(
      leftButtonLabel: 'shared.cancel'.tr(),
      onLeftButtonPressed: () => context.popView(),
      rightButtonLabel: 'purchases.complete'.tr(),
      onRightButtonPressed: () => context.popView(),
    );
  }
}
