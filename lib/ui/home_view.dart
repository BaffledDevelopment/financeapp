import 'package:finances/ui/widgets/title_application_bar.dart';
import 'package:flutter/material.dart';

import 'package:finances/viewmodels/home_model.dart';
import 'package:finances/ui/widgets/application_drawer.dart';
import 'package:finances/enum_viewstate.dart';
import 'package:finances/ui/widgets/base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) async => await model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(model.appBarTitle, model),
        drawer: AppDrawer(context),
        floatingActionButton: Visibility(
          visible: model.show,
          child: const CircularProgressIndicator()
          // AppFAB(model.closeMonthPicker),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Stack(
          children: <Widget>[
            Column(
              // children: <Widget>[
              //   SummaryWidget(
              //     income: model.incomeSum,
              //     expense: model.expenseSum,
              //   ),
              //   buildList(model.transactions, model),
              // ],
            ),
            // model.isCollabsed
            //     ? PickMonthOverlay(
            //     model: model,
            //     showOrHide: model.isCollabsed,
            //     context: context)
            //     : Container(),
          ],
        ),
      ),
    );
  }

  buildAppBar(String title, HomeModel model) {
    return AppBar(
      title: AppBarTitle(
        title: title,
        model: model,
      ),
    );
  }

  // buildList(List<Transaction> transactions, HomeModel model) {
  //   return transactions.length == 0
  //       ? EmptyTransactionsWidget()
  //       : TransactionsListView(transactions, model);
  // }
}