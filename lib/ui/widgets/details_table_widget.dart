import 'package:flutter/material.dart';

import '../../models/transaction.dart';

class DetailsTable extends StatelessWidget {
  const DetailsTable({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final ExpenseTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {1: FixedColumnWidth(250)},
      children: [
        TableRow(
          children: [
            const Text(
              "Category",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.type,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const Text(
              "Money",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.amount.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const Text(
              "Date",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.day + ", " + transaction.month,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const Text(
              "Note",
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.note,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}
