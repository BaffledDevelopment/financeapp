import 'package:finances/database/databaseimpl.dart';
import 'package:finances/models/transaction.dart';
import 'package:finances/ui/views/auth_view.dart';
import 'package:finances/ui/views/create_new_transaction_view.dart';
import 'package:finances/ui/views/details_view.dart';
import 'package:finances/ui/views/edit_view.dart';
import 'package:finances/ui/views/home_view.dart';
import 'package:finances/ui/views/new_transaction_view.dart';
import 'package:finances/ui/views/piechart_view.dart';
import 'package:finances/ui/views/register_view.dart';
import 'package:finances/ui/views/selector_view.dart';
import 'package:finances/ui/views/spline_chart_view.dart';
import 'package:flutter/material.dart';

const String initialRoute = "login";

final data = [
  LinearSales(0, 100),
  LinearSales(1, 75),
  LinearSales(2, 25),
  LinearSales(3, 5),
];

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
        return MaterialPageRoute(builder: (_) => StatisticsExpense());
      case 'select':
        return MaterialPageRoute(builder: (_) => SelectorMonView());
      case 'spline_chart':
        return MaterialPageRoute(builder: (_) => SplineChartView());
      case 'edit':
        var transaction = settings.arguments as ExpenseTransaction;
        return MaterialPageRoute(builder: (_) => EditView(transaction));
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'details':
        ExpenseTransaction transaction = settings.arguments as ExpenseTransaction;
        return MaterialPageRoute(builder: (_) => DetailsView(transaction));
      case 'registration':
        return MaterialPageRoute(builder: (_) => SignupPage());

      case 'create_transaction':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                CreateNewTransactionView(args.elementAt(0), args.elementAt(1)));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
