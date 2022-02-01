import 'package:finances/services/icon_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:finances/enum_viewstate.dart';
import 'package:finances/locator.dart';


class HomeModel extends BaseModel {
  bool isCollapsed = false;
  String appBarTitle; // month is selected
  String selectedYear;
  int selectedMonthIndex; // list months

  final CategoryIconService _categoryIconService = locator<CategoryIconService>();

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

  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);
    appBarTitle = clickedMonth;

    expenseSum = 333;
    incomeSum = 444;
    titleClicked();
  }

  int expenseSum = 0;
  int incomeSum = 0;

  titleClicked() {
    isCollapsed = !isCollapsed;
    notifyListeners();
  }

  bool show = true;

  init() async {

    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[selectedMonthIndex];

    // TODO: implement loading data from database for expense and income hence the listeners

    expenseSum = 1000;
    incomeSum = 500;

    print("Expense : $expenseSum");
    print("Income : $incomeSum");

    // show the loading bar
    setState(ViewState.Busy);
    notifyListeners();

    // show the list
    setState(ViewState.Idle);
    notifyListeners();
  }

  // thinking about handling scrolls because we use list

}
