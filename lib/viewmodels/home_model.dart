import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/auth_service.dart';
import 'package:finances/services/database_service.dart';
import 'package:finances/viewmodels/base_model.dart';



import 'package:finances/enum_viewstate.dart';
import 'package:finances/locator.dart';
import 'package:flutter/material.dart';

class HomeModel extends BaseModel {
  final DataBaseService _dataBaseService =
  locator<DataBaseService>();



  List<Transaction> transactions = List<Transaction>.empty();
  bool isCollapsed = false;
  late String appBarTitle;
  late String selectedYear;
  late int selectedMonthIndex;

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  monthClicked(String clickedMonth) {
    selectedMonthIndex = months.indexOf(clickedMonth);

    appBarTitle = clickedMonth;

    titleClicked();
  }

  titleClicked() {
    isCollapsed = !isCollapsed;
    notifyListeners();
  }

  getColor(month) {
    int monthIndex = months.indexOf(month);
    // color the selected month with
    if (monthIndex == selectedMonthIndex) {
      return Colors.orange;
    } else {
      return Colors.black;
    }
  }

  init() async {
    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[DateTime.now().month - 1];

    setState(ViewState.Busy);
    notifyListeners();

    transactions = await _dataBaseService.getAllTransactions(appBarTitle);

    setState(ViewState.Idle);
    notifyListeners();
  }
}