import 'package:finances/services/icon_service.dart';
import 'package:finances/viewmodels/home_model.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

// https://medium.com/nerd-for-tech/implement-service-locator-design-pattern-with-get-it-flutter-5e50671bbbcb

void setupLocator() {
  //SERVICES
  locator.registerLazySingleton(() => CategoryIconService());

  //VIEWMODELS
  locator.registerFactory(() => HomeModel());

}
