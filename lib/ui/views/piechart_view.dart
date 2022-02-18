// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PieChartView extends StatelessWidget {
  // final List<charts.Series> seriesList;

  // PieChartView();
  //
  //
  //
  // static List<charts.Series<LinearSales, int>> _createSampleData() {
  //   final data = [
  //     new LinearSales(0, 100),
  //     new LinearSales(1, 75),
  //     new LinearSales(2, 25),
  //     new LinearSales(3, 5),
  //   ];
  //
  //   return [
  //     new charts.Series<LinearSales, int>(
  //       id: 'Sales',
  //       domainFn: (LinearSales sales, _) => sales.year,
  //       measureFn: (LinearSales sales, _) => sales.sales,
  //       data: data,
  //     )
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
  }

  /// Create one series with sample hard coded data.


/// Sample linear data type.
