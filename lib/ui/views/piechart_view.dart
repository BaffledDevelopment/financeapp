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

      if (item.type == "income") {
        if (incomeMap
                .containsKey(incomeCategories[int.parse(item.categoryIndex)]) ==
            false) {
          incomeMap[
              incomeCategories[int.parse(item.categoryIndex)].toString()] = 1;
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
              1;
        }
      } else if (item.type == "expense") {
        if (expenseMap.containsKey(
                expenseCategories[int.parse(item.categoryIndex)].toString()) ==
            false) {
          expenseMap[
              expenseCategories[int.parse(item.categoryIndex)].toString()] = 1;
        } else {
          expenseMap[
                  expenseCategories[int.parse(item.categoryIndex)].toString()] =
              expenseMap[expenseCategories[int.parse(item.categoryIndex)]
                      .toString()]! +
                  1;
        }
      }
    }

    print("Income map entries");
    print(incomeMap.entries);

    print("Expense map entries");
    print(expenseMap.entries);

    if (selectedItem == 1) {
      return incomeMap;
    } else {
      return expenseMap;
    }

    // test[item.categoryIndex] = test[item.categoryIndex]! + 1;
  }

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
      centerText: _expense[0].type.toString(),
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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

                  if (model.selectedItem == 2) {

                    selectedItem = model.selectedItem;

                    return pieChartExampleOne();
                  } else {

                    selectedItem = model.selectedItem;

                    return pieChartExampleOne();
                  }
                },
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
