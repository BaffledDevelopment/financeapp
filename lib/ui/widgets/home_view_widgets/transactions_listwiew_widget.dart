import 'package:finances/viewmodels/home_model.dart';
import 'package:flutter/material.dart';

import '../../../models/transaction.dart';

class TransactionsListView extends StatelessWidget {
  final List<ExpenseTransaction>? transactions;
  final HomeModel model;

  const TransactionsListView(
    this.transactions,
    this.model,
  );

  @override
  Widget build(BuildContext context) {

    String textForCurrency = "";
    if (model.selectedItem == 1){
      textForCurrency = "USD";
    }

    String buildCurrencyDescription(ExpenseTransaction transaction) {

      String currencyDescription = "";

      // USD - default option
      if (model.selectedItem == 1) {
        currencyDescription = transaction.type +
            ": " +
            (transaction.amount).toString() + " USD";

        // RUB - second option
      } else if (model.selectedItem == 2) {
        currencyDescription = "RUB/USD ratio is: 74 ---> " + transaction.type +
            ": " +
            (transaction.amount  * 74).toString() + " RUB";

        // popugs - third option
      } else if (model.selectedItem == 3) {
        currencyDescription = "POPUG/USD ratio is: 0.1 ---> " + transaction.type +
            ": " +
            (transaction.amount * 0.1).toStringAsPrecision(3) + " POPUG";
      }

      return  currencyDescription;
    }

    String buildCurrencyForTile(ExpenseTransaction transaction) {

      String currencyDescription = "";

      // USD - default option
      if (model.selectedItem == 1) {
        currencyDescription =
            (transaction.amount).toString() + " USD";

        // RUB - second option
      } else if (model.selectedItem == 2) {
        currencyDescription =
            (transaction.amount  * 74).toString() + " RUB";

        // popugs - third option
      } else if (model.selectedItem == 3) {
        currencyDescription = (transaction.amount * 0.2).toStringAsPrecision(3) + " POPUG";
      }

      return  currencyDescription;
    }

    return Flexible(
      child: ListView(
        padding: EdgeInsets.all(8),
        children: transactions!.map((transaction) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "details", arguments: transaction)
                    .then((value) => {
                          if (value != null)
                            {
                              if (value == true)
                                {print("Transaction deleted"), model.init(false)}
                              else
                                {print("Not deleted")}
                            }
                        });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          transaction.day + '/' + transaction.month,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),

                        Text(
                          buildCurrencyDescription(transaction),

                          style: TextStyle(fontWeight: FontWeight.w300),
                        )

                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.withOpacity(.15),
                        child: model.getIconForCategory(
                            transaction.categoryindex, transaction.type),
                      ),
                      title: Text(transaction.note),
                      trailing: Text(buildCurrencyForTile(transaction),
                          style: TextStyle(fontSize: 20)
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
