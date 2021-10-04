import 'package:get_it/get_it.dart';

late GetIt _instance;

void setUpDependencies(GetIt getIt) {
  _instance = getIt;
}

T getDependency<T extends Object>() {
  return _instance.get<T>();
}
