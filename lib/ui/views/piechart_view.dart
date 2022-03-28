import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/ui/views/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../viewmodels/piechart_model.dart';
import '../widgets/new_transaction_view_widget/transaction_income_expense_slider.dart';
import '../widgets/rebuild_pie_chart_widget.dart';

class StatisticsExpense extends StatefulWidget {
  @override
  _StatisticsExpenseState createState() => _StatisticsExpenseState();
}

class _StatisticsExpenseState extends State<StatisticsExpense> {

  PieChartModel pieChartModel = PieChartModel();

  String centerOfPieChartText = "Income";

  final user = FirebaseAuth.instance.currentUser!;

  Widget pieChartExampleOne() {
    return PieChart(
      key: ValueKey(pieChartModel.key),
      dataMap: pieChartModel.getcategoryIndexData(),
      initialAngleInDegree: 0,
      animationDuration: Duration(milliseconds: 2000),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      ringStrokeWidth: 32,
      colorList: pieChartModel.colorList,
      chartLegendSpacing: 32,
      chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          showChartValueBackground: true,
          showChartValues: true,
          chartValueStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      centerText: centerOfPieChartText,
      legendOptions: const LegendOptions(
          showLegendsInRow: false,
          showLegends: true,
          legendShape: BoxShape.rectangle,
          legendPosition: LegendPosition.right,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> expStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("transaction")
        .snapshots();

    void getExpfromSanapshot(snapshot, String month) {
      if (snapshot.docs.isNotEmpty) {
        pieChartModel.expense = [];
        for (int i = 0; i < snapshot.docs.length; i++) {
          var a = snapshot.docs[i];
          print("_______________________________");
          print(a.data());
          print("this was a.data()");

          Expense exp = Expense.fromJson(a.data());

          print(exp.toString());

          if (exp.month == month) {
            pieChartModel.expense.add(exp);
          }
            else {
            pieChartModel.expense.add(exp);
          }
        }
      }
    }

    return BaseView<PieChartModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: TransactionTypeSpinnerPieChart(
              model!.selectedItem, model.changeSelectedItem),
          backgroundColor: Colors.cyan,
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              StreamBuilder<Object>(
                stream: expStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final data = snapshot.requireData;
                  print("Data: $data");
                  print(model.months[model.selectedMonthIndex]);

                  getExpfromSanapshot(data, model.months[model.selectedMonthIndex]);

                  // swapping charts income\expense
                  if (model.selectedItem == 2) {
                    centerOfPieChartText = "Expense";
                  } else {
                    centerOfPieChartText = "Income";
                  }

                  pieChartModel.selectedItem = model.selectedItem;
                  model.isSelected = true;
                  return pieChartExampleOne();
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 20, color: Colors.cyan))),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Summary',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.teal[800],
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans',
                      fontSize: 40),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Amount gained:' + pieChartModel.sumIncome.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                          fontSize: 40),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Amount spent:' + pieChartModel.sumExpenses.toString(),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Open Sans',
                          fontSize: 40),
                    ),
                  ),
                  ChipsChoice<int>.single(
                    choiceStyle: C2ChoiceStyle(elevation: 1, color: Colors.red),
                    value: model.selectedMonthIndex,
                    wrapped: true,
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: model.months,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                    onChanged: (val) => model.changeSelectedMonth(val),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Expense {
  int amount;
  String categoryIndex;
  String type;
  String month;

  Expense({
    required this.amount,
    required this.categoryIndex,
    required this.type,
    required this.month
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      amount: json['amount'],
      categoryIndex: json['categoryIndex'].toString(),
      type: json['type'],
      month: json['month']
    );
  }
}
