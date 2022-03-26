import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/models/category.dart';
import 'package:finances/services/icon_service.dart';
import 'package:finances/services/database_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moor/moor.dart';
// import 'package:toast/toast.dart';

import '../../locator.dart';

class EditModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final DataBaseService _dataBaseService = locator<DataBaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

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
  DateTime selectedDate = new DateTime.now();
  late Category category;

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

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Today ' + selectedMonth + ',' + selectedDay;
    } else {
      return selectedMonth + ',' + selectedDay;
    }
  }

  void init(Transaction transaction) {
    // initla values are current day and month
    selectedMonth = transaction.month;
    selectedDay = transaction.day;
    if (transaction.type == 'income') {
      category =
          _categoryIconService.incomeList.elementAt(transaction.categoryindex);
    } else {
      category =
          _categoryIconService.expenseList.elementAt(transaction.categoryindex);
    }
    memoController.text = transaction.memo;
    amountController.text = transaction.amount.toString();
    notifyListeners();
  }

  editTransaction(context, transaction) async {
    String memo = memoController.text;
    String amount = amountController.text;

    if (memo.isEmpty || amount.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill all the fields!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    final newTransaction = TransactionsCompanion(
        type: Value.ofNullable(transaction.type),
        day: Value.ofNullable(transaction.day),
        month: Value.ofNullable(transaction.month),
        memo: Value.ofNullable(transaction.memo),
        amount: Value.ofNullable(transaction.amount),
        categoryindex: Value.ofNullable(transaction.categoryindex));
    // insert it!
    await _dataBaseService.updateTransaction(newTransaction);

    Fluttertoast.showToast(
        msg: "Edited successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    // return to the home

    Navigator.of(context).pushNamedAndRemoveUntil(
        'details', (Route<dynamic> route) => false,
        arguments: newTransaction);
  }
}
