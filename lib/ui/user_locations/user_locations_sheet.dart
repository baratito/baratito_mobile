import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/ui/user_locations/search_user_locations_view.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:baratito_core/baratito_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/bottom_sheets/bottom_sheet_base.dart';

class UserLocationsSheet extends StatelessWidget {
  final UserLocationsCubit userLocationsCubit;

  const UserLocationsSheet({
    Key? key,
    required this.userLocationsCubit,
  }) : super(key: key);

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
    return BlocBuilder<UserLocationsCubit, UserLocationsState>(
      bloc: userLocationsCubit,
      builder: (context, state) {
        if (state is! UserLocationsLoaded) return Container();
        final userLocations = state.locations;
        return Expanded(
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.fromLTRB(
              padding,
              context.responsive(12),
              padding,
              0,
            ),
            children: [
              for (final location in userLocations)
                Padding(
                  padding: EdgeInsets.only(bottom: context.responsive(12)),
                  child: IconListItem(
                    title: location.name,
                    subtitle1: location.address,
                    iconColor: location.enabled
                        ? context.theme.colors.greenAccent
                        : context.theme.colors.greyAccent,
                    icon: BaratitoIcons.location,
                    onPressed: () => _enableLocation(location),
                  ),
                ),
              IconListItem(
                title: 'user_locations.new_location'.tr(),
                iconColor: context.theme.colors.greyAccent,
                icon: BaratitoIcons.plusSquare,
                actionIcon: BaratitoIcons.arrowRight,
                onPressed: () => _navigateToCreateUserLocation(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _enableLocation(UserLocation userLocation) {
    userLocationsCubit.enable(userLocation: userLocation);
  }

  void _navigateToCreateUserLocation(BuildContext context) {
    final mapLocationsSearchCubit = getDependency<MapLocationsSearchCubit>();
    context.pushView(
      SearchUserLocationsView(
        mapLocationsSearchCubit: mapLocationsSearchCubit,
        onSuccess: () {
          userLocationsCubit.get();
          context.popView();
          context.popView();
        },
      ),
    );
  }
}
