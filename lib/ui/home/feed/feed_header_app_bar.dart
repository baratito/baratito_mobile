import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/home/feed/search_box_button.dart';

class FeedHeaderAppBar extends StatefulWidget {
  final double expandedHeight;

  final bool showCollapsedAppBar;

  const FeedHeaderAppBar({
    Key? key,
    required this.expandedHeight,
    this.showCollapsedAppBar = false,
  }) : super(key: key);

  @override
  State<FeedHeaderAppBar> createState() => _FeedHeaderAppBarState();
}

class _FeedHeaderAppBarState extends State<FeedHeaderAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _greetingTitleFadeAnimation;
  late Animation<double> _searchFadeAnimation;

  final _fadeCurve = Curves.easeInOut;

  @override
  void initState() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );
    _setUpGreetingAnimations();
    _setUpSearchFadeAnimation();
    _fadeController.forward();
    super.initState();
  }

  void _setUpGreetingAnimations() {
    _greetingTitleFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Interval(
          .1,
          .4,
          curve: _fadeCurve,
        ),
      ),
    );
  }

  void _setUpSearchFadeAnimation() {
    _searchFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Interval(
          .6,
          1,
          curve: _fadeCurve,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimensionTheme = context.theme.dimensions as MobileDimensionTheme;
    final collapsedHeight = dimensionTheme.appBarHeight;
    final horizontalPadding = dimensionTheme.appBarHorizontalPadding;
    return SliverAppBar(
      expandedHeight: widget.expandedHeight,
      collapsedHeight: collapsedHeight,
      pinned: true,
      elevation: 0,
      backgroundColor: context.theme.colors.background,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        titlePadding: EdgeInsets.zero,
        title: _buildCollapsedAppBar(context, horizontalPadding),
        background: _buildExpandedAppBar(horizontalPadding, collapsedHeight),
      ),
    );
  }

  Widget _buildCollapsedAppBar(BuildContext context, double padding) {
    return AnimatedOpacity(
      opacity: widget.showCollapsedAppBar ? 1 : 0,
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

  Widget _buildExpandedAppBar(double padding, double collapsedHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildExpandedTopHeader(collapsedHeight),
          const Spacer(),
          _buildGreetingTexts(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _buildSearchBoxButton(),
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

  Widget _buildGreetingTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedFade(
          animation: _greetingTitleFadeAnimation,
          child: Text(
            'feed.greeting.header'.tr(args: ['Lautaro']),
            style: context.theme.text.headline2,
          ),
        ),
        AnimatedFade(
          animation: _searchFadeAnimation,
          child: Text(
            'feed.greeting.body'.tr(),
            style: context.theme.text.title,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBoxButton() {
    return AnimatedFade(
      animation: _searchFadeAnimation,
      child: SearchBoxButton(
        placeholder: 'Buscar productos...',
        onPressed: () {},
      ),
    );
  }
}
