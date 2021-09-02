import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:baratito_mobile/di/di.config.dart';

late GetIt getDependency;

@injectableInit
void setUpDependencies(GetIt getIt) {
  getDependency = $initGetIt(getIt);
}
