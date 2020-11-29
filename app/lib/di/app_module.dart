import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/index.dart';

class AppModule extends Module {
  @override
  void configure(GetIt get) =>
      get..registerSingleton(NavigationService(GlobalKey<NavigatorState>()));
}
