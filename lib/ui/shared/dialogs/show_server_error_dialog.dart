import 'package:baratito_mobile/ui/shared/dialogs/show_confirm_error_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showServerErrorDialog({required BuildContext context}) {
  return showConfirmErrorDialog(
    context: context,
    title: 'failures.server_title'.tr(),
    message: 'failures.server_body'.tr(),
  );
}
