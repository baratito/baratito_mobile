import 'package:baratito_mobile/ui/shared/dialogs/show_confirm_error_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showConnectionErrorDialog({required BuildContext context}) {
  return showConfirmErrorDialog(
    context: context,
    title: 'failures.connection_title'.tr(),
    message: 'failures.connection_body'.tr(),
  );
}
