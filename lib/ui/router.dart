import 'package:finances/ui/views/home_view.dart';
import 'package:flutter/material.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      //add splash?
      // need routes for dashboard, pie chart, stats, data screen, some more?
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());

      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}