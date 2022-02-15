import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  final int income;
  final int expense;

  const SummaryWidget({required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Income', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),

                  Text(income.toString(), style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600))
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Expense',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),

                  Text(expense.toString(), style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600))
                ],
              ),
              Text(
                '|',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w200),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Balance',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),

                  Text((income - expense).toString(),
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}