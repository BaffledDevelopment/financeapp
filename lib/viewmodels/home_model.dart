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

  List<String> months = [
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

  int selectedItem = 1;

  String type = "income";

  List<String> types = ["Income", "Expense"];

  changeType(int val) async {
    // 0 => income
    // 1 => expense
    if (val == 0) {
      type = 'income';

    } else {
      type = 'expense';
    }

    setState(ViewState.Busy);

    transactions = await _firebaseDatabaseService.getListExpensesForMonthWithIncome(user, months[selectedMonthIndex], type);

    setState(ViewState.Idle);

    notifyListeners();
  }

  changeSelectedMonth(int val) async {
    selectedMonthIndex = val;

    setState(ViewState.Busy);

    transactions = await _firebaseDatabaseService.getListExpensesForMonthWithIncome(user, months[selectedMonthIndex], type);

    setState(ViewState.Idle);

    notifyListeners();
  }

  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);

    appBarTitle = clickedMonth;


    expenseSum = await _firebaseDatabaseService.getExpenseSum(user);
    incomeSum = await _firebaseDatabaseService.getIncomeSum(user);

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

  init(bool firstTime) async {
    if (firstTime) selectedMonthIndex = DateTime.now().month - 1;

    appBarTitle = months[DateTime.now().month - 1];

    expenseSum = await _firebaseDatabaseService.getExpenseSum(user);
    incomeSum = await _firebaseDatabaseService.getIncomeSum(user);

    print("Expense : $expenseSum");
    print("Income : $incomeSum");

    setState(ViewState.Busy);
    notifyListeners();

    transactions = await _firebaseDatabaseService.transactionListFromSnapshot(user);

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

  Future<void> changeSelectedItem(int newItemIndex) async {

    selectedItem = newItemIndex;

    print("I select item");
    print(selectedItem);
    print("***************");
    //
    // setState(ViewState.Busy);
    //
    // transactions = await _firebaseDatabaseService.getListExpensesForMonthWithIncome(user, months[selectedMonthIndex], type);
    //
    // setState(ViewState.Idle);

    notifyListeners();
  }
}
