import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final int income;
  final int expense;

  const SummaryWidget({required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text('Income',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      Text(income.toString(),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600))
                    ],
                  ),
                  const Text(
                    '|',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w200),
                  ),
                  Column(
                    children: <Widget>[
                      const Text(
                        'Expense',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(expense.toString(),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600))
                    ],
                  ),
                  const Text(
                    '|',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w200),
                  ),
                  Column(
                    children: <Widget>[
                      const Text(
                        'Balance',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text((income - expense).toString(),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600))
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Row(
                children: <Widget>[
                  const Text("Прогноз остатка c учетом инфляции на:",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
          // SizedBox(
          //   height: 5,),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3 месяца: " + (income * 1.003).toStringAsPrecision(3) + " (-0,3% к покупательной способности)",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                      Text("6 месяцев: " + (income * 1.0058).toStringAsPrecision(3) + " (-0,58% к покупательной способности)",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                      Text("12 месяцев: " + (income * 1.015).toStringAsPrecision(3) + " (-1,59% к покупательной способности)",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
