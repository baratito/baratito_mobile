import 'package:baratito_ui/baratito_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showConfirmErrorDialog({
  required BuildContext context,
  required String title,
  required String message,
}) {
  return showDialog(
    context: context,
    barrierColor: context.themeValue.colors.greyAccent.withOpacity(.2),
    builder: (_) {
      return ConfirmErrorDialog(
        title: title,
        content: message,
        confirmButtonLabel: 'failures.confirm'.tr(),
      );
    },
  );
}
