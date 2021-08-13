import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/bottom_sheets/bottom_sheet_base.dart';

class UserLocationsSheet extends StatelessWidget {
  const UserLocationsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const minRatio = .8;
    const maxRatio = 1.0;
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: minRatio,
      maxChildSize: maxRatio,
      minChildSize: minRatio,
      builder: (_, scrollController) {
        return BottomSheetBase(
          title: 'user_locations.select'.tr(),
          child: _buildUserLocationsList(context, scrollController),
        );
      },
    );
  }

  Widget _buildUserLocationsList(
    BuildContext context,
    ScrollController scrollController,
  ) {
    final padding = (context.theme.dimensions as MobileDimensionTheme)
        .viewHorizontalPadding;
    return Expanded(
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: padding),
        children: [
          IconListItem(
            title: 'Casa',
            subtitle1: 'Maestro Vidal 1461',
            iconColor: context.theme.colors.greenAccent,
            icon: BaratitoIcons.location,
          ),
          IconListItem(
            title: 'Casa lauti',
            subtitle1: 'Armengol Tecera 64',
            iconColor: context.theme.colors.greyAccent,
            icon: BaratitoIcons.location,
          ),
          IconListItem(
            title: 'Nueva ubicación',
            iconColor: context.theme.colors.greyAccent,
            icon: BaratitoIcons.plusSquare,
            actionIcon: BaratitoIcons.arrowRight,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
