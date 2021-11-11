import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/user_locations/map_location_search_item.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/ui/user_locations/create_user_location_view.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_debounce_it/just_debounce_it.dart';

class SearchUserLocationsView extends StatefulWidget {
  /// Function to call when the location searching/creation succeds
  final VoidCallback? onSuccess;
  final MapLocationsSearchCubit mapLocationsSearchCubit;

  const SearchUserLocationsView({
    Key? key,
    required this.mapLocationsSearchCubit,
    this.onSuccess,
  }) : super(key: key);

  @override
  State<SearchUserLocationsView> createState() =>
      _SearchUserLocationsViewState();
}

class _SearchUserLocationsViewState extends State<SearchUserLocationsView> {
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
        title: 'user_locations.search_title'.tr(),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          padding,
          context.responsive(16),
          padding,
          0,
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildSearchInput(),
        BlocBuilder<MapLocationsSearchCubit, MapLocationsSearchState>(
          bloc: widget.mapLocationsSearchCubit,
          builder: (context, state) {
            if (state is MapLocationsSearchLoading) return _buildLoading();
            if (state is MapLocationsSearchResultsFound) {
              return Expanded(child: _buildResults(state));
            }
            return Container();
          },
        )
      ],
    );
  }

  Widget _buildLoading() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Spinner()],
      ),
    );
  }

  Widget _buildSearchInput() {
    return RoundedInput.large(
      placeholder: 'user_locations.search_placeholder'.tr(),
      autofocus: true,
      onValueChanged: _onSearchTextChanged,
    );
  }

  void _onSearchTextChanged(String value) {
    Debounce.milliseconds(400, widget.mapLocationsSearchCubit.search, [], {
      const Symbol('query'): value,
    });
  }

  Widget _buildResults(MapLocationsSearchResultsFound state) {
    final mapLocations = state.mapLocations;
    return ListView.builder(
      padding: EdgeInsets.only(top: context.responsive(16)),
      itemCount: mapLocations.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: context.responsive(12)),
          child: _buildItem(mapLocations[index]),
        );
      },
    );
  }

  Widget _buildItem(MapLocation mapLocation) {
    return MapLocationSearchItem(
      mapLocation: mapLocation,
      onPressed: () => _onLocationSelected(mapLocation),
    );
  }

  void _onLocationSelected(MapLocation mapLocation) {
    final userLocationCreateCubit = getDependency<UserLocationCreateCubit>();
    userLocationCreateCubit.load(mapLocation: mapLocation);
    context.pushView(
      CreateUserLocationView(
        userLocationCreateCubit: userLocationCreateCubit,
        onSuccess: widget.onSuccess,
      ),
    );
  }
}
