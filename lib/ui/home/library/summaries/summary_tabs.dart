import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/extensions/responsive_extension.dart';
import 'package:baratito_mobile/ui/home/library/summaries/summary_detail.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class SummaryTabs extends StatefulWidget {
  final List<MonthlyPurchaseSummary> summaries;

  const SummaryTabs({
    Key? key,
    required this.summaries,
  }) : super(key: key);

  @override
  _SummaryTabsState createState() => _SummaryTabsState();
}

class _SummaryTabsState extends State<SummaryTabs>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    final summariesCount = widget.summaries.length;
    final initialIndex = DateTime.now().month - 1;
    _controller = TabController(
      length: summariesCount,
      initialIndex: initialIndex,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabs(),
        Expanded(child: _buildPages()),
      ],
    );
  }

  Widget _buildTabs() {
    final theme = context.theme.text.body.copyWith(
      fontWeight: FontWeight.w600,
    );
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: TabBar(
        controller: _controller,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: _CircleTabIndicator(
          color: context.theme.colors.primary,
          radius: 4,
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: context.responsive(12, axis: Axis.horizontal),
        ),
        labelStyle: theme,
        unselectedLabelColor: theme.color!.withOpacity(.4),
        tabs: [
          for (final summary in widget.summaries)
            Tab(
              text: summary.abbreviation.replaceFirst(
                summary.abbreviation[0],
                summary.abbreviation[0].toUpperCase(),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildPages() {
    return TabBarView(
      controller: _controller,
      children: [
        for (final summary in widget.summaries) _buildPage(summary),
      ],
    );
  }

  Widget _buildPage(MonthlyPurchaseSummary summary) {
    return SummaryDetail(summary: summary);
  }
}

class _CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  _CircleTabIndicator({
    required Color color,
    required double radius,
  }) : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration box) {
    final Offset circleOffset = offset +
        Offset(
          box.size!.width / 2,
          box.size!.height - radius,
        );
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
