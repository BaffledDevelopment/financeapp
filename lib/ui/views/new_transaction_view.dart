import 'package:finances/ui/widgets/new_transaction_view_widget/transaction_income_expense_slider.dart';
import 'package:finances/viewmodels/new_transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';


class NewTransactionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<NewTransactionModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: TransactionTypeSpinner(
              model!.selectedItem, model.changeSelectedItem),
        ),
        body: SafeArea(
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 1.2,
            padding: EdgeInsets.all(8),
            children: model
                .loadCategoriesIcons()
                .map((e) => Card(
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context!).pushNamed("create_transaction",
                        arguments: [e, model.selectedItem]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(e.name),
                        Container(height: 10.0,),
                        CircleAvatar(
                          radius: 25,
                          child: Icon(
                            e.icon,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                )))
                .toList(),
          ),
        ),
      ),
    );
  }
}