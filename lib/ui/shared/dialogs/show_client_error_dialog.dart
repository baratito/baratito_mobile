import 'package:baratito_mobile/ui/shared/dialogs/show_confirm_error_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showClientErrorDialog({
  required BuildContext context,
  required String description,
}) {
  return showConfirmErrorDialog(
    context: context,
    title: 'failures.client_title'.tr(),
    message: description,
  );
}
