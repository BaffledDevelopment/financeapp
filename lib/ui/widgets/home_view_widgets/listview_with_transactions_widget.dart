import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finances/viewmodels/home_model.dart';

import '../../../models/transaction.dart';

class ListViewTransactions extends StatelessWidget {
  final List<ExpenseTransaction> transactions;
  final HomeModel model;

  const ListViewTransactions(
    this.transactions,
    this.model,
  );

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView(
            children: transactions.map((transaction) {
      return Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "details", arguments: transactions);
          },
        ),
      );
    }).toList()));
  }
}
