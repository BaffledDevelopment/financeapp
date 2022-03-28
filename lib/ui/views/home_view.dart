import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:finances/services/firebase_database_service.dart';
import 'package:finances/ui/widgets/application_drawer.dart';
import 'package:finances/ui/widgets/home_view_widgets/app_bar.dart';
import 'package:finances/ui/widgets/home_view_widgets/no_transactions_widget.dart';
import 'package:finances/ui/widgets/home_view_widgets/summary.dart';
import 'package:finances/ui/widgets/home_view_widgets/transactions_listwiew_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finances/viewmodels/home_model.dart';
import 'package:finances/ui/views/base_view.dart';

import 'package:finances/ui/widgets/home_view_widgets/application_floactbut.dart';

import '../../enum_viewstate.dart';
import '../../models/transaction.dart';
import '../rounded_button.dart';


class HomeView extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!;
  FirebaseDatabaseService fdb_service = FirebaseDatabaseService();


  @override
  Widget build(BuildContext context) {

    return BaseView<HomeModel>(

      onModelReady: (model) async => await model.init(true),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(model!.appBarTitle, model),
        drawer: AppDrawer(context!),
        floatingActionButton: ApplicationFloActBut(model.closeMonthPicker),
        // push to new transaction
        body: model.state == ViewState.Busy
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ChipsChoice<int>.single(
                        choiceStyle: C2ChoiceStyle(elevation: 1, color: Colors.red),
                        value: model.selectedMonthIndex,
                        wrapped: true,
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: model.months,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                        onChanged: (val) => model.changeSelectedMonth(val),
                      ),
                      ChipsChoice<int>.single(
                        choiceStyle:
                        C2ChoiceStyle(elevation: 1, color: Colors.green),
                        value: model.type == 'income' ? 0 : 1,
                        wrapped: true,
                        choiceItems: C2Choice.listFrom<int, String>(
                          source: model.types,
                          value: (i, v) => i,
                          label: (i, v) => v,
                        ),
                        onChanged: (val) => model.changeType(val),
                      ),

                      // Text(user.email!),
                      // Text(user.uid),
                      // RoundedButton(
                      //     text: "Press me",
                      //     press: () => fdb_service.saveDatabaseToCSVFile(user),
                      // ),

                      SummaryWidget(
                          income: model.incomeSum, expense: model.expenseSum),
                      buildList(model.transactions, model)
                    ],
                  ),
                  model.isCollapsed
                      ? buildOverlayPicker(model.isCollapsed, model, context)
                      : Container(),
                ],
              ),
      ),
    );
  }

  buildOverlayPicker(showOrHide, HomeModel model, BuildContext context) {
    Navigator.of(context).pushNamed("select");
  }

  buildAppBar(String title, HomeModel model) {
    return AppBar(
      title: MyAppBar(
        title: title,
        model: model,
      ),
        backgroundColor: Colors.cyan
    );
  }

  buildList(List<ExpenseTransaction>? transactions, HomeModel model) {


    print("INFO ABOUT TRANSACTIONINFO ABOUT TRANSACTIONINFO ABOUT TRANSACTIONINFO ABOUT TRANSACTIONINFO ABOUT TRANSACTIONINFO ABOUT TRANSACTIONINFO ABOUT TRANSACTIONINFO ABOUT TRANSACTION");
    print(transactions);
    print(transactions?.toList());
    print(transactions.toString());


    if (transactions != null) {
      return TransactionsListView(transactions, model);
    } else {
      return const NoTransactionsWidget();
    }
    // return transactions.isEmpty
    //     ? const NoTransactionsWidget()
    //     : TransactionsListView(transactions, model);
  }
}
