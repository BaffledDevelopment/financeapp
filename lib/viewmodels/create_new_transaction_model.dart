import 'package:finances/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/database_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../locator.dart';

class CreateNewTransactionModel extends BaseModel {

  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final DataBaseService _databaseService =
  locator<DataBaseService>();

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

  late String selectedDay;
  late String selectedMonth;
  DateTime selectedDate = DateTime.now();
  late String type;
  late int categoryIndex;

  Future selectDate(context) async {
    // hide the keyboard
    unFocusFromTheTextField(context);

    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void init(int selectedCategory, int index) {
    // starting values are current day&month
    selectedMonth = months[DateTime.now().month - 1];
    selectedDay = DateTime.now().day.toString();
    type = (selectedCategory == 1) ? 'income' : 'expense';
    categoryIndex = index;
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Today ' + selectedMonth + ',' + selectedDay;
    } else {
      return selectedMonth + ',' + selectedDay;
    }
  }

  addTransaction(context) async {
    String amount = amountController.text;



    Transaction newTransaction = Transaction(
        type: type,
        day: selectedDay,
        month: selectedMonth,
        memo: memoController.text,
        amount: int.parse(amount),
        categoryindex: categoryIndex);
    // insert it!
    await _databaseService.insertTransaction(newTransaction);


    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
  }
}