import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/transaction.dart';

class FirebaseDatabaseService {
  FirebaseDatabaseService();

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateExpenses(
    String type,
    String day,
    String month,
    int amount,
    String note,
    int categoryIndex,
  ) async {
    // Todo FILL THIS
  }

  Future<void> addExpenses({
    required User user,
    required String type,
    required String day,
    required String month,
    required int amount,
    required String note,
    required int categoryIndex,
  }) async {
    await expenseCollection.doc(user.uid).collection("transaction").add({
      "type": type,
      "day": day,
      "month": month,
      "amount": amount,
      "note": note,
      "categoryIndex": categoryIndex
    });

    Fluttertoast.showToast(
        msg: "Added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);

  }

  Future<void> getAllExpenses(User user) async {
    var userDoc =
        await expenseCollection.where('email', isEqualTo: user.email).get();

    // var users = expenseCollection.doc(user.uid).collection("").where('email', isEqualTo: user.email).get();

    userDoc.docs.forEach((element) {
      print(element.data());
    });
  }

  Future<List<ExpenseTransaction>?> transactionFromSnapshot(User user) async {

    try {
      List<ExpenseTransaction> transactionList = [];

      var querySnapshot =
      await expenseCollection.doc(user.uid).collection("transaction").get();

      // transactionList.add(ExpenseTransaction.fromJson(querySnapshot.docs[1].data()));

      transactionList = querySnapshot.docs.map((e) => ExpenseTransaction.fromJson(e.data())).toList();

      print("Contents of list");

      transactionList.forEach((e) {
        print(e.type);
        print(e.day);
        print(e.month);
        print(e.note);
        print(e.amount);
        print(e.categoryindex);
        print(e.type);

        print("________________________________");

      });

      return transactionList;

    } catch (err) {

      print(err);

    }

  }

  Future<void> deleteExpense(User user) async {}

  Future<void> updateExpense(User user) async {}

  Future<int> getIncomeSum(User user) async {

    var querySnapshot =
    await expenseCollection.doc(user.uid).collection("transaction").get();

    return 5;

  }

  Future<void> getExpenseSum(User user) async {}

  Future<void> getListExpensesOverallSum(User user) async {}

  Future<void> getListExpensesForMonth(User user) async {}
}
