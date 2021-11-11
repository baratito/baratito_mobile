import 'package:baratito_core/baratito_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/ui/shared/dialogs/show_confirm_error_dialog.dart';
import 'package:baratito_mobile/ui/shared/dialogs/show_connection_error_dialog.dart';
import 'package:baratito_mobile/ui/shared/dialogs/show_not_found_error_dialog.dart';
import 'package:baratito_mobile/ui/shared/dialogs/show_server_error_dialog.dart';

Future<void> showFailureDialog({
  required BuildContext context,
  required ApplicationFailure failure,
}) {
  if (failure is NotFoundFailure) {
    return showNotFoundErrorDialog(context: context);
  }
  if (failure is ServerFailure) {
    return showServerErrorDialog(context: context);
  }
  if (failure is ConnectionFailure) {
    return showConnectionErrorDialog(context: context);
  }
  return showConfirmErrorDialog(
    context: context,
    title: 'failures.unhandled_title'.tr(),
    message: 'failures.unhandled_body'.tr(),
  );
}
