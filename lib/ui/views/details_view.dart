import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/viewmodels/details_model.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:finances/ui/views/base_view.dart';
import 'package:finances/ui/widgets/details_card_widget.dart';

class DetailsView extends StatelessWidget {
  final Transaction transaction;
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
                      //todo delete dialog with onAlertPopUp or che tam bilo?
                    },
                  ),
                ],
              ),
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
                    backgroundColor: const Color.fromARGB(255, 255, 241, 159),
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

}