import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

List<Color> getMarkerColors(BuildContext context) {
  final theme = context.themeValue.colors;
  final colors = [
    theme.redAccent,
    theme.cyanAccent,
    theme.greenAccent,
    theme.primary,
  ];
  return colors;
}
