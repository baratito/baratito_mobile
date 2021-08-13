import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/configs/configs.dart';

extension ResponsiveExtension on BuildContext {
  double responsive(
    double size, {
    Axis axis = Axis.vertical,
  }) {
    final currentSize =
        axis == Axis.horizontal ? screenSize.width : screenSize.height;
    final designSize = axis == Axis.horizontal
        ? Constants.designSize.width
        : Constants.designSize.height;

    return size * currentSize / designSize;
  }

  bool get isIos => Theme.of(this).platform == TargetPlatform.iOS;
}
