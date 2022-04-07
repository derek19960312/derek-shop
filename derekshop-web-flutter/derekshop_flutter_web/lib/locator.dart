import 'package:derekshop_flutter_web/api/api.dart';
import 'package:derekshop_flutter_web/api/api_client.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Api>(() => Api());
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator.registerLazySingleton<Logger>(() => Logger());
}