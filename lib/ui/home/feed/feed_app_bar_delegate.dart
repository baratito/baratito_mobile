import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/di/di.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/feed/avatar_settings_button.dart';
import 'package:baratito_mobile/ui/notifications/notifications.dart';
import 'package:baratito_mobile/ui/user_locations/user_locations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedAppBarDelegate extends SliverPersistentHeaderDelegate {
  final bool showTitle;
  final String avatarUrl;
  final VoidCallback? onAvatarPressed;

  FeedAppBarDelegate({
    required this.avatarUrl,
    this.onAvatarPressed,
    this.showTitle = false,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _FeedAppBar(
      showTitle: showTitle,
      avatarUrl: avatarUrl,
      onAvatarPressed: onAvatarPressed,
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _FeedAppBar extends StatefulWidget {
  final bool showTitle;
  final String avatarUrl;
  final VoidCallback? onAvatarPressed;

  const _FeedAppBar({
    Key? key,
    required this.avatarUrl,
    this.onAvatarPressed,
    this.showTitle = false,
  }) : super(key: key);

  @override
  State<_FeedAppBar> createState() => _FeedAppBarState();
}

class _FeedAppBarState extends State<_FeedAppBar> {
  late bool _showTitle;
  late UserLocationsCubit _userLocationsCubit;

  @override
  void initState() {
    _showTitle = widget.showTitle;
    _userLocationsCubit = getDependency<UserLocationsCubit>();
    _userLocationsCubit.get();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _FeedAppBar oldWidget) {
    if (widget.showTitle != oldWidget.showTitle) {
      setState(() => _showTitle = widget.showTitle);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final padding = (context.theme.dimensions as MobileDimensionTheme)
        .appBarHorizontalPadding;
    final crossFadeState =
        _showTitle ? CrossFadeState.showSecond : CrossFadeState.showFirst;
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.symmetric(horizontal: padding),
      color: context.theme.colors.background,
      child: AnimatedCrossFade(
        firstChild: _buildContent(context),
        secondChild: _buildTitle(context),
        crossFadeState: crossFadeState,
        duration: const Duration(milliseconds: 300),
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: context.responsive(8, axis: Axis.horizontal),
          ),
          child: AvatarSettingsButton(
            avatarUrl: widget.avatarUrl,
            onPressed: widget.onAvatarPressed,
          ),
        ),
        _buildUserLocations(context),
        const Spacer(),
        NotificationsButton(
          onTap: () {
            context.pushView(const NotificationsView());
          },
        ),
      ],
    );
  }

  Widget _buildUserLocations(BuildContext context) {
    return BlocBuilder<UserLocationsCubit, UserLocationsState>(
      bloc: _userLocationsCubit,
      builder: (context, state) {
        if (state is! UserLocationsLoaded) return Container();
        final selectedLocation = state.getEnabledLocation();
        return SelectionButton(
          label: selectedLocation?.name ?? 'user_locations.select'.tr(),
          onTap: () {
            context.showBottomSheet(
              UserLocationsSheet(userLocationsCubit: _userLocationsCubit),
            );
          },
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: context.responsive(12, axis: Axis.horizontal),
          ),
          child: const BaratitoIsotype(),
        ),
        Expanded(
          child: Text(
            'feed.title'.tr(),
            style: context.theme.text.headline1,
            textAlign: TextAlign.center,
          ),
        ),
        IconActionButton(
          icon: BaratitoIcons.search,
          onTap: () {},
        ),
      ],
    );
  }
}
