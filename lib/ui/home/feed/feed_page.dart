import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/home/feed/feed_header_app_bar.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _controller = ScrollController();
  final _headerAppBarHeightRatio = .33;

  bool _showCollapsedAppBar = false;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;

    final dimensionTheme =
        context.themeValue.dimensions as MobileDimensionTheme;

    final collapsedAppBarHeight = dimensionTheme.appBarHeight;
    final expandedAppBarHeight =
        context.screenSize.height * _headerAppBarHeightRatio;

    final offset = _controller.offset;

    setState(() {
      _showCollapsedAppBar =
          offset > expandedAppBarHeight - collapsedAppBarHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final expandedAppBarHeight =
        context.screenSize.height * _headerAppBarHeightRatio;

    return NestedScrollView(
      controller: _controller,
      headerSliverBuilder: (_, __) => [
        FeedHeaderAppBar(
          expandedHeight: expandedAppBarHeight,
          showCollapsedAppBar: _showCollapsedAppBar,
        )
      ],
      body: ListView(
        children: const [SizedBox(height: 1000)],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
