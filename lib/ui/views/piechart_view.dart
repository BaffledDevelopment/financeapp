import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsExpense extends StatefulWidget {
  @override
  _StatisticsExpenseState createState() => _StatisticsExpenseState();
}

class _StatisticsExpenseState extends State<StatisticsExpense> {

  final user = FirebaseAuth.instance.currentUser!;
  int key = 0;

  late List<Expense> _expense = [];

  Map<String, double> getcategoryIndexData() {
    Map<String, double> catMap = {};
    for (var item in _expense) {
      print(item.categoryIndex);
      if (catMap.containsKey(item.categoryIndex.toString()) == false) {
        catMap[item.categoryIndex.toString()] = 1;
      } else {
        catMap.update(item.categoryIndex.toString(), (int) => catMap[item.categoryIndex.toString()]! + 1);
        // test[item.categoryIndex] = test[item.categoryIndex]! + 1;
      }
      print(catMap);
    }
    return catMap;
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
    final Stream<QuerySnapshot> expStream =
    FirebaseFirestore.instance.collection('users').doc(user.uid).collection("transaction").snapshots();

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

    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.menu),
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
                  return Text("something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final data = snapshot.requireData;
                print("Data: $data");
                getExpfromSanapshot(data);
                return pieChartExampleOne();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Expense {
  int amount;
  String categoryIndex;
  String type;

  Expense(
      {required this.amount,
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
