// import 'package:finances/database/databaseimpl.dart';
import 'dart:math';

import 'package:finances/services/auth_service.dart';
import 'package:finances/services/database_service.dart';
import 'package:finances/services/firebase_database_service.dart';
import 'package:finances/services/icon_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:finances/models/transaction.dart';

import 'package:finances/enum_viewstate.dart';
import 'package:finances/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModel extends BaseModel {

  final FirebaseDatabaseService _firebaseDatabaseService = locator<FirebaseDatabaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  final user = FirebaseAuth.instance.currentUser!;

  List<ExpenseTransaction>? transactions = List<ExpenseTransaction>.empty();
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


    expenseSum = await _firebaseDatabaseService.getExpenseSum(user);
    incomeSum = await _firebaseDatabaseService.getIncomeSum(user);

    // expenseSum = await _dataBaseService.getExpenseSum(appBarTitle);
    // incomeSum = await _dataBaseService.getIncomeSum(appBarTitle);

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

    expenseSum = await _firebaseDatabaseService.getExpenseSum(user);
    incomeSum = await _firebaseDatabaseService.getIncomeSum(user);

    // expenseSum = await _dataBaseService.getExpenseSum(appBarTitle);
    // incomeSum = await _dataBaseService.getIncomeSum(appBarTitle);

    print("Expense : $expenseSum");
    print("Income : $incomeSum");

    setState(ViewState.Busy);
    notifyListeners();

    transactions = await _firebaseDatabaseService.transactionListFromSnapshot(user);

    // transactions = await _dataBaseService.getAllTransactions(appBarTitle);
    // поменяй эту строчку на чтение из фаербейса

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
