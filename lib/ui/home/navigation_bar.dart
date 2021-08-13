import 'package:baratito_ui/baratito_ui.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class NavigationBarItem extends Equatable {
  final IconData activeIcon;
  final IconData inactiveIcon;

  const NavigationBarItem({
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  List<Object?> get props => [activeIcon, inactiveIcon];
}

typedef OnItemSelected = void Function(int index);

class NavigationBar extends StatelessWidget {
  final List<NavigationBarItem> items;
  final int activeItemIndex;
  final OnItemSelected? onItemSelected;

  const NavigationBar({
    Key? key,
    required this.items,
    required this.activeItemIndex,
    this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = context.screenSize.width;
    final height =
        (context.theme.dimensions as MobileDimensionTheme).navigationBarHeight;
    return Container(
      height: context.responsive(height),
      width: width,
      decoration: BoxDecoration(
        color: context.theme.colors.background,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsive(40, axis: Axis.horizontal),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [..._buildItems()],
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    return items.asMap().entries.map<Widget>((item) {
      return _NavigationBarButton(
        activeIcon: item.value.activeIcon,
        inactiveIcon: item.value.inactiveIcon,
        onPressed:
            onItemSelected != null ? () => onItemSelected!(item.key) : null,
        isActive: activeItemIndex == item.key,
      );
    }).toList();
  }
}

class _NavigationBarButton extends StatefulWidget {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final VoidCallback? onPressed;
  final bool isActive;

  const _NavigationBarButton({
    Key? key,
    required this.activeIcon,
    required this.inactiveIcon,
    this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<_NavigationBarButton> createState() => _NavigationBarButtonState();
}

class _NavigationBarButtonState extends State<_NavigationBarButton>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _setUpSlideAnimation();
    _setUpFadeAnimation();
    _setUpScaleAnimation();
    if (widget.isActive) {
      _slideController.value = 1;
      _fadeController.value = 1;
    }
    super.initState();
  }

  void _setUpSlideAnimation() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = _slideController.curvedAnimation(
      begin: 0.0,
      end: 1.0,
      curve: Curves.ease,
    );
  }

  void _setUpFadeAnimation() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _fadeAnimation = _fadeController.curvedAnimation(
      begin: 0.0,
      end: 1.0,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _setUpScaleAnimation() {
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = _scaleController.curvedAnimation(
      begin: 1.0,
      end: 1.2,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _forwardSlideFade() {
    _slideController.forward();
    _fadeController.forward();
  }

  void _reverseSlideFade() {
    _slideController.reverse();
    _fadeController.reverse();
  }

  Future<void> _forwardScale() async {
    await _scaleController.forward().orCancel;
    await _scaleController.reverse().orCancel;
  }

  @override
  void didUpdateWidget(covariant _NavigationBarButton oldWidget) {
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _forwardSlideFade();
        return;
      }
      _reverseSlideFade();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onPressed() async {
    await _forwardScale();
    if (widget.onPressed != null) widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await _onPressed(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: _buildIcons(),
      ),
    );
  }

  Widget _buildIcons() {
    final height =
        (context.theme.dimensions as MobileDimensionTheme).navigationBarHeight;
    final iconSize = context.theme.dimensions.actionIconLarge;
    final boxSize = iconSize + 24;
    final animationSlideAmount = context.responsive(height) / 3;
    return SizedBox.square(
      dimension: boxSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _AnimatedVerticalSlide(
            animation: _slideAnimation,
            slideAmount: animationSlideAmount,
            child: _AnimatedFade(
              animation: _fadeAnimation,
              child: SizedBox.square(
                dimension: boxSize,
                child: Center(
                  child: Icon(
                    widget.inactiveIcon,
                    size: iconSize,
                    color: context.theme.colors.disabled,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: animationSlideAmount,
            child: _AnimatedVerticalSlide(
              animation: _slideAnimation,
              slideAmount: animationSlideAmount,
              child: _AnimatedFade(
                reverse: true,
                animation: _fadeAnimation,
                child: SizedBox.square(
                  dimension: boxSize,
                  child: Center(
                    child: Icon(
                      widget.activeIcon,
                      size: iconSize,
                      color: context.theme.colors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedVerticalSlide extends AnimatedWidget {
  final Widget child;

  /// Amount of logical pixels for [child] to be slided towards.
  final double slideAmount;

  final Animation<double> animation;

  const _AnimatedVerticalSlide({
    Key? key,
    required this.child,
    required this.slideAmount,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final yOffsetValue = slideAmount * animation.value;

    return Transform.translate(
      offset: Offset(0, yOffsetValue),
      child: child,
    );
  }
}

class _AnimatedFade extends AnimatedWidget {
  final Widget child;
  final bool reverse;
  final Animation<double> animation;

  const _AnimatedFade({
    Key? key,
    required this.child,
    required this.animation,
    this.reverse = false,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final opacityValue = reverse ? animation.value : (1 - animation.value);
    return Opacity(opacity: opacityValue, child: child);
  }
}
