import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:finances/enum_viewstate.dart';
import 'package:finances/viewmodels/piechart_model.dart';
import 'package:finances/ui/views/base_view.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PieChartModel>(
      onModelReady: (model) => model.init(true),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Chart'),
        ),
        body: model?.state == ViewState.Busy
            ? CircularProgressIndicator()
            : SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: <Widget>[
                  ChipsChoice<int>.single(
                    choiceStyle: C2ChoiceStyle(
                        elevation: 1, color: Colors.red),
                    value: model!.selectedMonthIndex,
                    wrapped: true,
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: model.months,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                    onChanged: (val) => model.changeSelectedMonth(val),
                  ),
                  ChipsChoice<int>.single(
                    choiceStyle: C2ChoiceStyle(
                        elevation: 1, color: Colors.green),
                    value: model.type == 'income' ? 0 : 1,
                    wrapped: true,
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: model.types,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                    onChanged: (val) => model.changeType(val),
                  ),
                  model.dataMap.length == 0
                      ? Text('No Data for this month')
                      : PieChart(dataMap: model.dataMap),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
