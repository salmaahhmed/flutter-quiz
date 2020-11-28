import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Injector extends InheritedWidget {
  static Injector of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  Injector._(Widget child) : super(child: child);

  factory Injector({
    @required Widget child,
    @required List<Module> modules,
  }) {
    final injector = Injector._(child);
    try {
      modules.forEach((m) => m.configure(injector._getIt));
    } catch (e) {
      print(e);
    }
    return injector;
  }
  final GetIt _getIt = GetIt.asNewInstance();
  @override
  bool updateShouldNotify(Injector old) => _getIt != old._getIt;

  T inject<T>() => _getIt.get<T>();
}
