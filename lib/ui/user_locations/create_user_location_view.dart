import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/staticmap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/ui/user_locations/map_location_search_item.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';
import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/shared/bottom_bars/bottom_bars.dart';

class CreateUserLocationView extends StatefulWidget {
  /// Function to call when the location searching/creation succeds
  final VoidCallback? onSuccess;
  final UserLocationCreateCubit userLocationCreateCubit;

  const CreateUserLocationView({
    Key? key,
    required this.userLocationCreateCubit,
    this.onSuccess,
  }) : super(key: key);

  @override
  _CreateUserLocationViewState createState() => _CreateUserLocationViewState();
}

class _CreateUserLocationViewState extends State<CreateUserLocationView> {
  @override
  Widget build(BuildContext context) {
    return View(
      appBar: MainAppBar(
        title: 'user_locations.create_title'.tr(),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: context.responsive(16)),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<UserLocationCreateCubit, UserLocationCreateState>(
      bloc: widget.userLocationCreateCubit,
      listener: (context, state) {
        if (state is UserLocationCreateFailed) {
          final failure = state.failure;
          showFailureDialog(context: context, failure: failure);
        } else if (state is UserLocationCreateSuccess) {
          if (widget.onSuccess != null) widget.onSuccess!();
        }
      },
      builder: (context, state) {
        if (state is UserLocationCreateLoading) return _buildLoading();
        if (state is UserLocationCreateData) {
          return _buildLocationContent(state);
        }
        return Container();
      },
    );
  }

  Widget _buildLocationContent(UserLocationCreateData state) {
    final mapLocation = state.mapLocation;
    return Column(
      children: [
        Expanded(child: _buildMapStack(mapLocation)),
        _buildBottomBar(),
      ],
    );
  }

  Widget _buildMapStack(MapLocation mapLocation) {
    return Stack(
      children: [
        _buildStaticMap(mapLocation),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildLocationData(mapLocation),
        ),
      ],
    );
  }

  Widget _buildStaticMap(MapLocation mapLocation) {
    final location = mapLocation.location;
    final staticMap = StaticMap(
      const String.fromEnvironment('MAPS_API_KEY'),
      markers: [
        Location(
          lat: location.latitude,
          lng: location.longitude,
        ),
      ],
      mapType: 'terrain',
      zoom: '15',
      size: _getStaticMapSize(),
    );
    final imageUrl = staticMap.getUrl();
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(32),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String _getStaticMapSize() {
    final screenSize = context.screenSize;
    final width = screenSize.width.toInt();
    final height = screenSize.height ~/ 1.5;
    return '${width}x$height';
  }

  Widget _buildLocationData(MapLocation mapLocation) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: context.responsive(24),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        color: context.theme.colors.background,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MapLocationSearchItem(mapLocation: mapLocation),
          Padding(
            padding: EdgeInsets.only(top: context.responsive(16)),
            child: _buildNameInput(mapLocation),
          )
        ],
      ),
    );
  }

  Widget _buildNameInput(MapLocation mapLocation) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'user_locations.alias'.tr(),
          style: context.theme.text.label,
        ),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(8)),
          child: RoundedInput(
            placeholder: 'user_locations.alias_placeholder'.tr(),
            onValueChanged: _onNameChanged,
          ),
        )
      ],
    );
  }

  void _onNameChanged(String value) {
    widget.userLocationCreateCubit.updateName(value);
  }

  Widget _buildBottomBar() {
    return DoubleButtonBottomBar(
      leftButtonLabel: 'shared.cancel'.tr(),
      onLeftButtonPressed: _onCancel,
      rightButtonLabel: 'shared.confirm'.tr(),
      onRightButtonPressed: _onConfirm,
    );
  }

  void _onCancel() => context.popView();

  void _onConfirm() {
    widget.userLocationCreateCubit.create();
  }

  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Spinner()],
        )
      ],
    );
  }
}
