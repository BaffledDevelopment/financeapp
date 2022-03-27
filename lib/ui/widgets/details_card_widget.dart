import 'package:flutter/material.dart';
import 'package:finances/viewmodels/details_model.dart';
import 'package:finances/ui/widgets/details_table_widget.dart';

import '../../models/transaction.dart';

class DetailsCard extends StatelessWidget {
  final ExpenseTransaction transaction;
  final DetailsModel model;

  DetailsCard({required this.transaction, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent.withOpacity(.1),
                  child: model.getIconForCategory(
                      transaction.categoryindex, transaction.type)),
              title: Text(
                "\t\t\t" +
                    model.getCategoryIconName(
                        transaction.categoryindex, transaction.type),
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            DetailsTable(transaction: transaction),
          ],
        ),
      ),
    );
  }
}
