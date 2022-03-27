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
  Map<int, String> incomeCategories = {
    0: "Salary",
    1: "Awards",
    2: "Grants",
    3: "Rental",
    4: "Investment",
    5: "Lottery",
  };

  String centerOfPieChartText = "Income";

  Map<int, String> expenseCategories = {
    0: "Food",
    1: "Bills",
    2: "Transportaion",
    3: "Home",
    4: "Entertainment",
    5: "Shopping",
    6: "Clothing",
    7: "Insurance",
    8: "Telephone",
    9: "Health",
    10: "Sport",
    11: "Beauty",
    12: "Education",
    13: "Gift",
    14: "Pet",
  };

  Map<String, double> incomeMap = {};
  Map<String, double> expenseMap = {};

  int selectedItem = 1;

  final user = FirebaseAuth.instance.currentUser!;
  int key = 0;

  late List<Expense> _expense = [];

  Map<String, double> getcategoryIndexData() {
    incomeMap = {};
    expenseMap = {};

    for (var item in _expense) {
      print(item.categoryIndex);

      // plot charts by amount, not by count of expenses of certain type

      // if (item.type == "income") {
      //   if (incomeMap
      //           .containsKey(incomeCategories[int.parse(item.categoryIndex)]) ==
      //       false) {
      //     incomeMap[
      //         incomeCategories[int.parse(item.categoryIndex)].toString()] = 1;
      //   } else {
      //     print("ENTRIES________ENTRIES");
      //     print(incomeMap.entries);
      //
      //     // в фаербейзе categoryIndex записан как Integer
      //     // в item оно вынужденно конвертируется в String из-за сериализации в Map<String, dynamic>
      //     // в справочной мапе incomeCategories Map<int, String> хранятся строки с пояснениями к индексу операции
      //     // в мапе incomeMap Map<String, double> хранится количество вхождений операций одного типа
      //     // для отрисовки сегментов piechart (принимают только Map<String, double>)
      //     // categoryIndex -> конверт в инт -> тянем название операции из справочной мапы
      //     // -> готов ключ для incomeMap и по нему тягаем циферьку :)
      //
      //     incomeMap[incomeCategories[int.parse(item.categoryIndex)]
      //         .toString()] = incomeMap[
      //             incomeCategories[int.parse(item.categoryIndex)].toString()]! +
      //         1;
      //   }
      // } else if (item.type == "expense") {
      //   if (expenseMap.containsKey(
      //           expenseCategories[int.parse(item.categoryIndex)].toString()) ==
      //       false) {
      //     expenseMap[
      //         expenseCategories[int.parse(item.categoryIndex)].toString()] = 1;
      //   } else {
      //     expenseMap[
      //             expenseCategories[int.parse(item.categoryIndex)].toString()] =
      //         expenseMap[expenseCategories[int.parse(item.categoryIndex)]
      //                 .toString()]! +
      //             1;
      //   }
      // }
      if (item.type == "income") {
        if (incomeMap
                .containsKey(incomeCategories[int.parse(item.categoryIndex)]) ==
            false) {
          incomeMap[incomeCategories[int.parse(item.categoryIndex)]
              .toString()] = (double.parse(item.amount.toString()));
        } else {
          print("ENTRIES________ENTRIES");
          print(incomeMap.entries);

          // в фаербейзе categoryIndex записан как Integer
          // в item оно вынужденно конвертируется в String из-за сериализации в Map<String, dynamic>
          // в справочной мапе incomeCategories Map<int, String> хранятся строки с пояснениями к индексу операции
          // в мапе incomeMap Map<String, double> хранится количество вхождений операций одного типа
          // для отрисовки сегментов piechart (принимают только Map<String, double>)
          // categoryIndex -> конверт в инт -> тянем название операции из справочной мапы
          // -> готов ключ для incomeMap и по нему тягаем циферьку :)

          incomeMap[incomeCategories[int.parse(item.categoryIndex)]
              .toString()] = incomeMap[
                  incomeCategories[int.parse(item.categoryIndex)].toString()]! +
              (double.parse(item.amount.toString()));
        }
      } else if (item.type == "expense") {
        if (expenseMap.containsKey(
                expenseCategories[int.parse(item.categoryIndex)].toString()) ==
            false) {
          expenseMap[expenseCategories[int.parse(item.categoryIndex)]
              .toString()] = (double.parse(item.amount.toString()));
        } else {
          expenseMap[
                  expenseCategories[int.parse(item.categoryIndex)].toString()] =
              expenseMap[expenseCategories[int.parse(item.categoryIndex)]
                      .toString()]! +
                  (double.parse(item.amount.toString()));
        }
      }
    }

    print("Income map entries");
    print(incomeMap.entries);

    print("Expense map entries");
    print(expenseMap.entries);

    sumExpenses = expenseMap.values.reduce((sum, element) => sum + element);
    sumIncome = incomeMap.values.reduce((sum, element) => sum + element);

    if (selectedItem == 1) {
      return incomeMap;
    } else {
      return expenseMap;
    }
  }

  var sumIncome = 0.0;
  var sumExpenses = 0.0;

  List<Color> colorList = [
    Color.fromRGBO(82, 98, 255, 1),
    Color.fromRGBO(46, 198, 255, 1),
    Color.fromRGBO(123, 201, 82, 1),
    Color.fromRGBO(255, 171, 67, 1),
    Color.fromRGBO(252, 91, 57, 1),
    Color.fromRGBO(139, 135, 130, 1),
  ];

  Widget pieChartExampleOne() {
    return PieChart(
      key: ValueKey(key),
      dataMap: getcategoryIndexData(),
      initialAngleInDegree: 0,
      animationDuration: Duration(milliseconds: 2000),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      ringStrokeWidth: 32,
      colorList: colorList,
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

    void getExpfromSanapshot(snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _expense = [];
        for (int i = 0; i < snapshot.docs.length; i++) {
          var a = snapshot.docs[i];
          print("_______________________________");
          print(a.data());
          print("this was a.data()");

          Expense exp = Expense.fromJson(a.data());
          _expense.add(exp);
          print(exp);
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
                  getExpfromSanapshot(data);

                  // swapping charts income\expense
                  if (model.selectedItem == 2) {
                    centerOfPieChartText = "Expense";

                    selectedItem = model.selectedItem;

                    return pieChartExampleOne();
                  } else {
                    centerOfPieChartText = "Income";

                    selectedItem = model.selectedItem;

                    return pieChartExampleOne();
                  }
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
                      'Amount gained:' + sumIncome.toString(),
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
                      'Amount spent:' + sumExpenses.toString(),
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

  Expense({
    required this.amount,
    required this.categoryIndex,
    required this.type,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      amount: json['amount'],
      categoryIndex: json['categoryIndex'].toString(),
      type: json['type'],
    );
  }
}
