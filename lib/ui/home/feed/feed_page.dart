import 'dart:math';

import 'package:baratito_mobile/ui/home/feed/feed_app_bar_delegate.dart';
import 'package:baratito_mobile/ui/home/feed/feed_header.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';
import 'package:baratito_mobile/ui/home/feed/feed_sections_staggered_list.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _controller = ScrollController();
  final _headerKey = GlobalKey();
  final _headerOpacity = ValueNotifier(1.0);

  bool _appBarTitleVisible = false;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;

    final currentScrollOffset = _controller.offset;
    final headerYOffset = _getWidgetHeaderYOffset();

    _updateHeaderOpacity(currentScrollOffset, headerYOffset);
    _updateAppBarTitleVisibility(currentScrollOffset, headerYOffset);
  }

  void _updateHeaderOpacity(double currentScrollOffset, double headerYOffset) {
    if (currentScrollOffset > headerYOffset) return;

    final headerOpacity = 1 - (currentScrollOffset / headerYOffset);
    // Clamping to prevent overscrolling from breaking Opacity widget
    _headerOpacity.value = min(1, max(0, headerOpacity));
  }

  void _updateAppBarTitleVisibility(
    double currentScrollOffset,
    double headerYOffset,
  ) {
    final souldShowTitle = currentScrollOffset >= headerYOffset;
    if (_appBarTitleVisible != souldShowTitle) {
      setState(() => _appBarTitleVisible = souldShowTitle);
    }
  }

  double _getWidgetHeaderYOffset() {
    final currentContext = _headerKey.currentContext;
    if (currentContext == null) return 0;

    final renderBox = currentContext.findRenderObject() as RenderBox;
    final height = renderBox.size.height;
    final offset = renderBox.localToGlobal(Offset.zero);

    return offset.dy + height;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        _buildAppBar(context),
        _buildHeader(context),
        _buildBody(context),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: FeedAppBarDelegate(
        showTitle: _appBarTitleVisible,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        AnimatedBuilder(
          animation: _headerOpacity,
          builder: (_, child) {
            return Opacity(
              opacity: _headerOpacity.value,
              child: child,
            );
          },
          child: FeedHeader(key: _headerKey),
        ),
      ]),
    );
  }

  Widget _buildBody(BuildContext context) {
    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;
    final padding = context.responsive(
      dimensionTheme.viewHorizontalPadding,
      axis: Axis.horizontal,
    );
    return SliverList(
      delegate: SliverChildListDelegate([
        FeedSectionsStaggeredList(
          sectionPadding: EdgeInsets.fromLTRB(padding, 16, padding, 0),
          sections: [
            FeedStaggeredListSection(
              title: 'Comprá lo de siempre',
              items: [
                IconListItem(
                  title: 'Cosas para subsistir',
                  subtitle1: '8 productos',
                  icon: BaratitoIcons.category,
                  iconColor: context.theme.colors.greenAccent,
                  actionIcon: BaratitoIcons.arrowRight,
                  onPressed: () {},
                ),
                IconListItem(
                  title: 'Para el asado',
                  subtitle1: '4 productos',
                  icon: BaratitoIcons.category,
                  iconColor: context.theme.colors.cyanAccent,
                  actionIcon: BaratitoIcons.arrowRight,
                  onPressed: () {},
                ),
                IconListItem(
                  title: 'Compra mensual con verduritas',
                  subtitle1: '16 productos',
                  icon: BaratitoIcons.category,
                  iconColor: context.theme.colors.greyAccent,
                  actionIcon: BaratitoIcons.arrowRight,
                  onPressed: () {},
                ),
              ],
            ),
            FeedStaggeredListSection(
              title: 'Otras listas recomendadas',
              items: [
                IconListItem(
                  title: 'Otra lista',
                  subtitle1: '8 productos',
                  icon: BaratitoIcons.category,
                  iconColor: context.theme.colors.redAccent,
                  actionIcon: BaratitoIcons.arrowRight,
                  onPressed: () {},
                ),
                IconListItem(
                  title: 'Una de test',
                  subtitle1: '4 productos',
                  icon: BaratitoIcons.category,
                  iconColor: context.theme.colors.primary,
                  actionIcon: BaratitoIcons.arrowRight,
                  onPressed: () {},
                ),
                IconListItem(
                  title: 'Pañuelitos de papel',
                  subtitle1: '1 productos',
                  icon: BaratitoIcons.category,
                  iconColor: context.theme.colors.greenAccent,
                  actionIcon: BaratitoIcons.arrowRight,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
