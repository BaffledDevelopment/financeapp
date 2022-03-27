import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/viewmodels/details_model.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:finances/ui/views/base_view.dart';
import 'package:finances/ui/widgets/details_card_widget.dart';

import '../../models/transaction.dart';

class DetailsView extends StatelessWidget {

  final ExpenseTransaction transaction;

  DetailsView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailsModel>(
        builder: (context, model, child) => WillPopScope(
              onWillPop: () {
                Navigator.of(context!).pushReplacementNamed('home');
                return Future.value(true);
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: InkWell(
                    child: const Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.of(context!).pushReplacementNamed('home');
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Details'),
                      InkWell(
                        child: const Icon(Icons.delete),
                        onTap: () {
                          showDeleteDialog(context!, model!);
                        },
                      ),
                    ],
                  ),
                  backgroundColor: Colors.cyan,
                ),
                body: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 300,
                      padding: const EdgeInsets.all(10.0),
                      child: DetailsCard(
                        transaction: transaction,
                        model: model!,
                      ),
                    ),
                    Positioned(
                      right: 18,
                      top: 235,
                      child: FloatingActionButton(
                        child: const Icon(Icons.edit, color: Colors.black38),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 241, 159),
                        onPressed: () {
                          Navigator.of(context!)
                              .pushNamed('edit', arguments: transaction);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  showDeleteDialog(BuildContext context, DetailsModel model) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete"),
            content: const Text(
                "Are you sure do you want to delete this transaction"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Delete",
                ),
                onPressed: () async {
                  await model.deleteTransacation(transaction);
                  // hide dialog
                  Navigator.of(context).pop();
                  // exit detailsscreen
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          );
        });
  }
}
