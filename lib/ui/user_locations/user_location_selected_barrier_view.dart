import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/user_locations/search_user_locations_view.dart';
import 'package:baratito_mobile/ui/user_locations/no_user_location_illustration.dart';
import 'package:baratito_mobile/ui/home/home.dart';
import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_mobile/ui/shared/shared.dart';

class UserLocationSelectedBarrierView extends StatefulWidget {
  const UserLocationSelectedBarrierView({Key? key}) : super(key: key);

  @override
  State<UserLocationSelectedBarrierView> createState() =>
      _UserLocationSelectedBarrierViewState();
}

class _UserLocationSelectedBarrierViewState
    extends State<UserLocationSelectedBarrierView> {
  late UserLocationsCubit _userLocationsCubit;

  @override
  void initState() {
    _userLocationsCubit = getDependency<UserLocationsCubit>();
    _userLocationsCubit.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLocationsCubit, UserLocationsState>(
      bloc: _userLocationsCubit,
      listener: (context, state) {
        if (state is UserLocationsLoaded) {
          if (state.getEnabledLocation() != null) {
            _navigateToHome();
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is! UserLocationsLoaded;
        if (!isLoading && (state as UserLocationsLoaded).locations.isNotEmpty) {
          return Container();
        }
        return View(
          child: Column(
            children: [
              if (!isLoading) _buildLogoBar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isLoading) _buildLoading(),
                    if (!isLoading) _buildContent()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogoBar() {
    return Padding(
      padding: EdgeInsets.only(
        top: context.responsive(40),
        left: context.responsive(24, axis: Axis.horizontal),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: context.responsive(8, axis: Axis.horizontal),
            ),
            child: const BaratitoLogotype(size: 120),
          ),
          const BaratitoIsotype(size: 20),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Spinner()],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const NoUserLocationIllustration(),
        _buildText(),
        Padding(
          padding: EdgeInsets.only(top: context.responsive(16)),
          child: _buildButton(),
        )
      ],
    );
  }

  Widget _buildText() {
    return Row(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.responsive(24),
              horizontal: context.responsive(32, axis: Axis.horizontal),
            ),
            child: Text(
              'user_locations.no_user_location'.tr(),
              textAlign: TextAlign.center,
              style: context.theme.text.body,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return PrimaryButton(
      icon: BaratitoIcons.location,
      label: 'user_locations.select'.tr(),
      onTap: _navigateToCreateUserLocation,
    );
  }

  void _navigateToHome() {
    context.pushReplacementView(
      const HomeView(),
      RouteTransitionType.fade,
    );
  }

  void _navigateToCreateUserLocation() {
    final mapLocationsSearchCubit = getDependency<MapLocationsSearchCubit>();
    context.pushView(
      SearchUserLocationsView(
        mapLocationsSearchCubit: mapLocationsSearchCubit,
        onSuccess: _navigateToHome,
      ),
    );
  }
}
