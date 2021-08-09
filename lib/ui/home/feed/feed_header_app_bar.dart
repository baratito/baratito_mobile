import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/home/feed/search_box_button.dart';

class FeedHeaderAppBar extends StatelessWidget {
  final double expandedHeight;

  final bool showCollapsedAppBar;

  const FeedHeaderAppBar({
    Key? key,
    required this.expandedHeight,
    this.showCollapsedAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensionTheme = context.theme.dimensions as MobileDimensionTheme;
    final collapsedHeight = dimensionTheme.appBarHeight;
    final horizontalPadding = dimensionTheme.appBarHorizontalPadding;
    return SliverAppBar(
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      pinned: true,
      elevation: 0,
      backgroundColor: context.theme.colors.background,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        titlePadding: EdgeInsets.zero,
        title: _buildCollapsedAppBar(context, horizontalPadding),
        background: _buildExpandedAppBar(
          context,
          horizontalPadding,
          collapsedHeight,
        ),
      ),
    );
  }

  Widget _buildCollapsedAppBar(BuildContext context, double padding) {
    return AnimatedOpacity(
      opacity: showCollapsedAppBar ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: padding),
              child: const BaratitoIsotype(),
            ),
            Expanded(child: Text('Feed', style: context.theme.text.headline1)),
            IconActionButton(
              icon: BaratitoIcons.search,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedAppBar(
    BuildContext context,
    double padding,
    double collapsedHeight,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildExpandedTopHeader(collapsedHeight),
          const Spacer(),
          _buildGreetingTexts(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SearchBoxButton(
              placeholder: 'Buscar productos...',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExpandedTopHeader(double collapsedHeight) {
    return SizedBox(
      height: collapsedHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: BaratitoIsotype(),
          ),
          SelectionButton(
            label: 'Maestro Vidal 1461',
            onTap: () {},
          ),
          const Spacer(),
          NotificationsButton(
            onTap: () {},
            showIndicator: true,
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'feed.greeting.header'.tr(args: ['Lautaro']),
          style: context.theme.text.headline2,
        ),
        Text('feed.greeting.body'.tr(), style: context.theme.text.title),
      ],
    );
  }
}
