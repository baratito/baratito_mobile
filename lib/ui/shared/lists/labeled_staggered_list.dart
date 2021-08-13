import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

class LabeledStaggeredList extends StatelessWidget {
  final String label;
  final List<Widget> children;
  final Duration itemFadeInDuration;
  final Duration staggerDelay;
  final Duration initialDelay;

  const LabeledStaggeredList({
    Key? key,
    required this.label,
    required this.children,
    this.itemFadeInDuration = const Duration(milliseconds: 500),
    this.staggerDelay = const Duration(milliseconds: 300),
    this.initialDelay = Duration.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredList(
      itemFadeInDuration: itemFadeInDuration,
      staggerDelay: staggerDelay,
      initialDelay: initialDelay,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildLabel(context),
        ),
        ...children,
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Row(
      children: [
        Text(label, style: context.theme.text.label),
      ],
    );
  }
}
