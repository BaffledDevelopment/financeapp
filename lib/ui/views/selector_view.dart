import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:finances/viewmodels/selector_model.dart';
import 'package:flutter/material.dart';
import 'package:finances/enum_viewstate.dart';
import 'package:finances/viewmodels/selector_model.dart';
import 'package:finances/ui/views/base_view.dart';
import 'package:pie_chart/pie_chart.dart';

class SelectorMonView extends StatelessWidget {
  const SelectorMonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectorMonModel>(
      onModelReady: (model) => model.init(true),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Pick month'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: <Widget>[
                  ChipsChoice<int>.single(
                    choiceStyle: C2ChoiceStyle(elevation: 1, color: Colors.red),
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
                    choiceStyle:
                        C2ChoiceStyle(elevation: 1, color: Colors.green),
                    value: model.type == 'income' ? 0 : 1,
                    wrapped: true,
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: model.types,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                    onChanged: (val) => model.changeType(val),
                  ),
                  // : SelectorMon(dataMap: model.dataMap),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
