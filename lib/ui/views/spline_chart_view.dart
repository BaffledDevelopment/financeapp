import 'package:finances/models/transaction.dart';
import 'package:finances/viewmodels/spline_chart_model.dart';
import 'package:flutter/material.dart';

import 'package:finances/models/expenses_chart_data.dart';
import 'package:finances/viewmodels/spline_chart_model.dart';
import 'package:finances/ui/views/base_view.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChartView extends StatelessWidget {
  const SplineChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BaseView<SplineChartModel>(


      onModelReady: (model) => model.init(true),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Spline Chart'),
          ),
          body: Column(
            children: [
              Container(
                  height: 300,
                  width: 350,
                  child: Card(
                      child: SfCartesianChart(
                          legend: Legend(
                              isVisible: false,
                              // position: LegendPosition.right,
                              width: '10%'),

                          // Initialize category axis
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                        // Initialize line series
                        LineSeries<ExpenseTransaction, String>(
                            dataSource: model!.dataList,
                            xValueMapper: (ExpenseTransaction sales, _) =>
                                sales.month + sales.day,
                            yValueMapper: (ExpenseTransaction sales, _) =>
                                sales.amount)
                      ])))
            ],
          )),
    );
  }
}
