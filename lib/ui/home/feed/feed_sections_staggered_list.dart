import 'dart:math';

import 'package:baratito_mobile/ui/shared/shared.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class FeedSectionsStaggeredList extends StatelessWidget {
  final List<FeedStaggeredListSection> sections;
  final EdgeInsets sectionPadding;

  const FeedSectionsStaggeredList({
    Key? key,
    required this.sections,
    this.sectionPadding = EdgeInsets.zero,
  }) : super(key: key);

  final _sectionStaggerDelay = const Duration(milliseconds: 300);
  final _sectionFadeInDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final staggerDelayInMilliseconds =
        _getMaxSectionAnimationDurationInMilliseconds();
    final staggerDelay = Duration(
      milliseconds: staggerDelayInMilliseconds,
    );
    return StaggeredList(
      staggerDelay: staggerDelay,
      itemFadeInDuration: Duration.zero,
      children: [
        for (var i = 0; i < sections.length; i++)
          Padding(
            padding: sectionPadding,
            child: _buildSection(i, staggerDelay * i),
          ),
      ],
    );
  }

  int _getMaxSectionAnimationDurationInMilliseconds() {
    final sectionAnimationDurations = sections.map<int>((section) {
      final sectionLengthMultiplier = section.items.length - 1;
      final sectionStaggerDuration =
          _sectionStaggerDelay * sectionLengthMultiplier;
      final sectionFadeInDuration =
          _sectionFadeInDuration * sectionLengthMultiplier;
      return (sectionStaggerDuration + sectionFadeInDuration).inMilliseconds;
    });
    return sectionAnimationDurations.reduce(max);
  }

  Widget _buildSection(int index, Duration initialDelay) {
    return LabeledStaggeredList(
      initialDelay: initialDelay,
      staggerDelay: _sectionStaggerDelay,
      itemFadeInDuration: _sectionFadeInDuration,
      label: sections[index].title,
      children: sections[index].items,
    );
  }
}

class FeedStaggeredListSection {
  final String title;
  final List<Widget> items;

  const FeedStaggeredListSection({required this.title, required this.items});
}
