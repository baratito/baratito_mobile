import 'dart:async';

import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/icons/icons.dart';

class CategoriesLoadingIndicator extends StatefulWidget {
  final double? size;

  const CategoriesLoadingIndicator({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  State<CategoriesLoadingIndicator> createState() =>
      _CategoriesLoadingIndicatorState();
}

class _CategoriesLoadingIndicatorState
    extends State<CategoriesLoadingIndicator> {
  late Timer _timer;
  final _categories = Category.values;
  int _currentIndex = 0;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) => _updateCurrentIndex(),
    );
    super.initState();
  }

  void _updateCurrentIndex() {
    final maximumIndex = _categories.length - 1;
    final newIndex = _currentIndex == maximumIndex ? 0 : (_currentIndex + 1);
    setState(() => _currentIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
    final indicatorSize = widget.size ?? context.theme.dimensions.iconRegular;
    final category = _categories[_currentIndex];
    return CategoryIcon(category: category, size: indicatorSize);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
