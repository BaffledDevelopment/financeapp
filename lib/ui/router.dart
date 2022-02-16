import 'package:finances/database/databaseimpl.dart';
import 'package:finances/ui/views/auth_view.dart';
import 'package:finances/ui/views/create_new_transaction_view.dart';
import 'package:finances/ui/views/details_view.dart';
import 'package:finances/ui/views/home_view.dart';
import 'package:finances/ui/views/new_transaction_view.dart';
import 'package:finances/ui/views/piechart_view.dart';
import 'package:finances/ui/views/spline_chart_view.dart';
import 'package:flutter/material.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      // need routes for dashboard, pie chart, stats, data screen, some more?
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'auth':
        return MaterialPageRoute(builder: (_) => AuthView());
      case 'new_transaction':
        return MaterialPageRoute(builder: (_) => NewTransactionView());
      case 'chart':
        return MaterialPageRoute(builder: (_) => PieChartView());
      case 'spline_chart':
        return MaterialPageRoute(builder: (_) => SplineChartView());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'details':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(builder: (_) => DetailsView(transaction));
      case 'create_transaction':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(builder: (_) =>
            CreateNewTransactionView(args.elementAt(0), args.elementAt(1)));

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