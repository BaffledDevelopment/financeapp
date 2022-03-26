import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/database_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../locator.dart';
import '../services/firebase_database_service.dart';

class CreateNewTransactionModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final fdb_service = FirebaseDatabaseService();
  final user = FirebaseAuth.instance.currentUser!;

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

  String convertTimeStampToId = Timestamp.now().seconds.toString();

  late String selectedDay;
  late String selectedMonth;
  // Timestamp timestamp = Timestamp.now();

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

    String memo = memoController.text;

    if (memo.isEmpty || amount.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill all the fields!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    await fdb_service.addExpenses(
        user: user,
        type: type,
        day: selectedDay.toString(),
        month: selectedMonth.toString(),
        amount: int.parse(amountController.text),
        note: memoController.text,
        categoryIndex: categoryIndex,
        id: convertTimeStampToId,
    );

    Fluttertoast.showToast(
        msg: "Added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);

    Navigator.of(context!)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);

    // return to the home
  }
}
