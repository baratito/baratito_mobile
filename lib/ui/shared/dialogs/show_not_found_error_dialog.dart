import 'package:baratito_mobile/ui/shared/dialogs/show_confirm_error_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showNotFoundErrorDialog({required BuildContext context}) {
  return showConfirmErrorDialog(
    context: context,
    title: 'failures.not_found_title'.tr(),
    message: 'failures.not_found_body'.tr(),
  );
}
