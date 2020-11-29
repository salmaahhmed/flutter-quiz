import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/model/index.dart';
import 'route_names.dart';
import 'package:quiz/pages/index.dart';
import 'package:quiz/extensions/index.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  RoutingData routingData = settings?.name?.getRoutingData;
  switch (routingData.route) {
    case QuestionRoute:
      Map<String, dynamic> params = settings.arguments;
      return _getPageRoute(
          QuestionPage(
            category: params["category"],
          ),
          settings);
    default:
      return _getPageRoute(HomePage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
