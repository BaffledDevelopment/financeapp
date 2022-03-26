import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/auth_service.dart';
import 'package:finances/services/database_service.dart';
import 'package:finances/services/icon_service.dart';
import 'package:finances/viewmodels/base_model.dart';

import 'package:finances/enum_viewstate.dart';
import 'package:finances/locator.dart';
import 'package:flutter/material.dart';

class HomeModel extends BaseModel {
  final DataBaseService _dataBaseService = locator<DataBaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

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

  int expenseSum = 0;
  int incomeSum = 0;

  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);

    appBarTitle = clickedMonth;

    expenseSum = await _dataBaseService.getExpenseSum(appBarTitle);
    incomeSum = await _dataBaseService.getIncomeSum(appBarTitle);

    titleClicked();
  }

  titleClicked() {
    isCollapsed = !isCollapsed;
    notifyListeners();
  }

  void closeMonthPicker() {
    isCollapsed = false;
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

    expenseSum = await _dataBaseService.getExpenseSum(appBarTitle);
    incomeSum = await _dataBaseService.getIncomeSum(appBarTitle);

    print("Expense : $expenseSum");
    print("Income : $incomeSum");

    setState(ViewState.Busy);
    notifyListeners();

    transactions = await _dataBaseService.getAllTransactions(appBarTitle);

    setState(ViewState.Idle);
    notifyListeners();
  }

  Icon getIconForCategory(int index, String type) {
    if (type == 'income') {
      final categoryIcon = _categoryIconService.incomeList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    } else {
      final categoryIcon = _categoryIconService.expenseList.elementAt(index);

      return Icon(
        categoryIcon.icon,
        color: categoryIcon.color,
      );
    }
  }
}
