import 'package:finances/database/databaseimpl.dart';
import 'package:finances/main.dart';
import 'package:finances/ui/widgets/application_drawer.dart';
import 'package:finances/ui/widgets/home_view_widgets/app_bar.dart';
import 'package:finances/ui/widgets/home_view_widgets/monthYearInterface.dart';
import 'package:finances/ui/widgets/home_view_widgets/no_transactions_widget.dart';
import 'package:finances/ui/widgets/home_view_widgets/summary.dart';
import 'package:finances/ui/widgets/home_view_widgets/transactions_listwiew_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:finances/viewmodels/home_model.dart';
import 'package:finances/ui/views/base_view.dart';

import 'package:finances/ui/widgets/home_view_widgets/application_floactbut.dart';

import '../../enum_viewstate.dart';
import '../../services/firebase_database_service.dart';
import '../rounded_button.dart';

class HomeView extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final fdb_service = FirebaseDatabaseService();
    return BaseView<HomeModel>(
      onModelReady: (model) async => await model.init(),
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
                      Text(user.email!),
                      Text(user.uid),
                      RoundedButton(
                          text: "Press me",
                          press: () => fdb_service.addExpenses(
                            type: "expense",
                            user: user,
                            note: 'Test',
                            amount: 450,
                            categoryIndex: 1,
                            month: 'Jan',
                            day: "Friday",
                          )),
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
    // return PickMonthAndYearOverlay();
    // return PickMonthAndYearOverlay(
    //     model: model, showOrHide: showOrHide, context: context);
  }

  buildAppBar(String title, HomeModel model) {
    return AppBar(
      title: MyAppBar(
        title: title,
        model: model,
      ),
    );
  }

  buildList(List<Transaction> transactions, HomeModel model) {
    return transactions.isEmpty
        ? const NoTransactionsWidget()
        : TransactionsListView(transactions, model);
  }
}
