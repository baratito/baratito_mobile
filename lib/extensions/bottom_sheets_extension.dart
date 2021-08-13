import 'package:flutter/material.dart';

extension BottomSheetExtension on BuildContext {
  Future<T?> showBottomSheet<T>(Widget child) async {
    return showModalBottomSheet<T>(
      context: this,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
  }
}
