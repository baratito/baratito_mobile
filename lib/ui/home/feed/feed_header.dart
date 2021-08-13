import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/feed/search_box_button.dart';

class FeedHeader extends StatefulWidget {
  const FeedHeader({Key? key}) : super(key: key);

  @override
  State<FeedHeader> createState() => _FeedHeaderState();
}

class _FeedHeaderState extends State<FeedHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _greetingTitleFadeAnimation;
  late Animation<double> _searchFadeAnimation;

  final _fadeCurve = Curves.easeInOut;
  final _initialDelay = const Duration(milliseconds: 400);
  final _greetingAnimationDuration = const Duration(milliseconds: 600);
  final _searchAnimationDuration = const Duration(milliseconds: 600);

  late Duration _totalAnimationDuration;

  @override
  void initState() {
    _totalAnimationDuration =
        _initialDelay + _greetingAnimationDuration + _searchAnimationDuration;
    _fadeController = AnimationController(
      vsync: this,
      duration: _totalAnimationDuration,
    );
    _setUpAnimations();
    _fadeController.forward();
    super.initState();
  }

  void _setUpAnimations() {
    final startGreeting =
        _initialDelay.inMilliseconds / _totalAnimationDuration.inMilliseconds;
    final endGreeting = _greetingAnimationDuration.inMilliseconds /
        _totalAnimationDuration.inMilliseconds;

    _greetingTitleFadeAnimation = _fadeController.curvedAnimation(
      begin: 0.0,
      end: 1.0,
      curve: Interval(startGreeting, endGreeting, curve: _fadeCurve),
    );

    final endSearch = endGreeting +
        _searchAnimationDuration.inMilliseconds /
            _totalAnimationDuration.inMilliseconds;

    _searchFadeAnimation = _fadeController.curvedAnimation(
      begin: 0.0,
      end: 1.0,
      curve: Interval(endGreeting, endSearch, curve: _fadeCurve),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = (context.theme.dimensions as MobileDimensionTheme)
        .viewHorizontalPadding;
    return Container(
      color: context.theme.colors.background,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsive(padding, axis: Axis.horizontal),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.responsive(64)),
              child: _buildGreetingTexts(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.responsive(16)),
              child: _buildSearchBoxButton(),
            )
          ],
        ),
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
        placeholder: 'products.search_placeholder'.tr(),
        onPressed: () {},
      ),
    );
  }
}
