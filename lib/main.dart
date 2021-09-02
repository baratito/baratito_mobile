import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final coreDependencies = await setUpCoreDependencies(Environment.mobile);
  setUpDependencies(coreDependencies);

  runApp(getDependency<App>());
}
