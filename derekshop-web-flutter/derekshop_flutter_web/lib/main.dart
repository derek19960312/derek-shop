import 'package:derekshop_flutter_web/shopping_repository.dart';
import 'package:derekshop_flutter_web/simple_bloc_observer.dart';
import 'package:derekshop_flutter_web/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'app.dart';
import 'api/dio_config.dart';


void main() async {
  // Production level should set to nothing
  Logger.level = Level.verbose;

  // Level.debug for testing
  //  Logger.level = Level.debug;
  setupLocator();

  BlocOverrides.runZoned(
    () => runApp(App(shoppingRepository: ShoppingRepository())),
    blocObserver: SimpleBlocObserver(),
  );
}
