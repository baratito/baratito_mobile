import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/feed/avatar_settings_button.dart';
import 'package:baratito_mobile/ui/notifications/notifications.dart';
import 'package:baratito_mobile/ui/shared/bottom_sheets/bottom_sheets.dart';

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

class _FeedAppBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final padding = (context.theme.dimensions as MobileDimensionTheme)
        .appBarHorizontalPadding;
    final crossFadeState =
        showTitle ? CrossFadeState.showSecond : CrossFadeState.showFirst;
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
            avatarUrl: avatarUrl,
            onPressed: onAvatarPressed,
          ),
        ),
        SelectionButton(
          label: 'Maestro Vidal 1461',
          onTap: () {
            context.showBottomSheet(const UserLocationsSheet());
          },
        ),
        const Spacer(),
        NotificationsButton(
          onTap: () {
            context.pushView(const NotificationsView());
          },
          showIndicator: true,
        ),
      ],
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
