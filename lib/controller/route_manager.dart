import 'package:flutter/cupertino.dart';

class RouteManager {
  static final RouteManager _instance = RouteManager._internal();

  factory RouteManager() => _instance;

  RouteManager._internal();

  void navigateToRoute(BuildContext context, String route) {
    Navigator.pop(context);
    /// only push if not already on current page to prevent multiple identical instances on stack
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushNamed(context, route);
    }
  }
}
