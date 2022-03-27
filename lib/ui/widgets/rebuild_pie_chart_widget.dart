import 'package:flutter/material.dart';

class TransactionTypeSpinnerPieChart extends StatelessWidget {
  final selectedItem;
  final Function changedSelectedItem;

  const TransactionTypeSpinnerPieChart(this.selectedItem, this.changedSelectedItem);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedItem,
        items: const [
          DropdownMenuItem(
            child: Text("Income"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("Expense"),
            value: 2,
          ),
        ],
        onChanged: (value) {
          changedSelectedItem(value);

        });
  }
}
