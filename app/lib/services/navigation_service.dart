import 'package:flutter/material.dart';
import 'package:quiz/routing/route_names.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationService(this.navigatorKey);

  Future<dynamic> navigateTo(String routeName,
      {Map<String, dynamic> queryParams}) {
    // if (routeName == CartRoute && queryParams != null) {
    //   routeName = Uri(
    //       path: routeName,
    //       queryParameters: {"userId": queryParams["userId"]}).toString();
    //   print("cart page query params" + queryParams.toString());
    //   return navigatorKey.currentState
    //       .pushNamed(routeName, arguments: queryParams);
    // }

    if (routeName == QuestionRoute && queryParams != null) {
      routeName = Uri(
          path: routeName,
          queryParameters: {"category": queryParams["categoryId"]}).toString();
      return navigatorKey.currentState
          .pushNamed(routeName, arguments: queryParams);
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
