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
    int id,
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
    required String id,
  }) async {
    await expenseCollection.doc(user.uid).collection("transaction").add({
      "type": type,
      "day": day,
      "month": month,
      "amount": amount,
      "note": note,
      "categoryIndex": categoryIndex,
      "id": id,
    });

    var getId = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("transaction").
    where("id", isEqualTo: id).get();


    var transactionID = getId.docs[0].id;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection("transaction")
        .doc(transactionID)
        .update({"id": transactionID})
        .then((value) => print("New Transaction ID added!"))
        .catchError((e) => print("Failed to change ID"));

    print("****************");
    print(transactionID);

    Fluttertoast.showToast(
        msg: "Added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  Future<void> getAllExpenses(User user) async {
    // var userDoc =
    //     await expenseCollection.where('email', isEqualTo: user.email).get();

    // var users = expenseCollection.doc(user.uid).collection("").where('email', isEqualTo: user.email).get();

    // userDoc.docs.forEach((element) {
    //   print(element.data());
    // });
  }

  Future<List<ExpenseTransaction>?> transactionListFromSnapshot(
      User user) async {
    try {
      List<ExpenseTransaction> transactionList = [];

      var querySnapshot =
          await expenseCollection.doc(user.uid).collection("transaction").get();

      // transactionList.add(ExpenseTransaction.fromJson(querySnapshot.docs[1].data()));

      transactionList = querySnapshot.docs
          .map((e) => ExpenseTransaction.fromJson(e.data()))
          .toList();

      print("Contents of list");

      // transactionList.forEach((e) {
      //   print(e.type);
      //   print(e.day);
      //   print(e.month);
      //   print(e.note);
      //   print(e.amount);
      //   print(e.categoryindex);
      //   print(e.type);
      //   print(e.id);
      //
      //   print("________________________________");
      // });

      return transactionList;
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteExpense(User user, ExpenseTransaction transaction) async {
    print("___________________");

    // print(transaction.id);
    print(transaction.id);

    await FirebaseFirestore.instance
        .collection('orders')
        .doc(user.uid)
        .collection('transaction')
        .doc(transaction.id)
        .delete();
  }

  Future<void> updateExpense(User user, ExpenseTransaction transaction) async {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(user.uid)
        .collection('transaction')
        .doc(transaction.id)
        .update({
      'type': transaction.type,
      'day': transaction.day,
      'month': transaction.month,
      'note': transaction.note,
      'id': transaction.id,
      'amount': transaction.amount,
      'categoryIndex': transaction.categoryindex
    });
  }

  Future<int> getIncomeSum(User user) async {
    int incomeSum = 0;

    var querySnapshot =
        await expenseCollection.doc(user.uid).collection("transaction").get();

    List<ExpenseTransaction> transactionList = [];

    transactionList = querySnapshot.docs
        .map((e) => ExpenseTransaction.fromJson(e.data()))
        .toList();

    transactionList.forEach((e) {
      if (e.type == "income") {
        incomeSum = incomeSum + e.amount;
      }
    });

    return incomeSum;
  }

  Future<int> getExpenseSum(User user) async {
    int expenseSum = 0;

    var querySnapshot =
        await expenseCollection.doc(user.uid).collection("transaction").get();

    List<ExpenseTransaction> transactionList = [];

    transactionList = querySnapshot.docs
        .map((e) => ExpenseTransaction.fromJson(e.data()))
        .toList();

    transactionList.forEach((e) {
      if (e.type == "expense") {
        expenseSum = expenseSum + e.amount;
      }
    });
    return expenseSum;
  }

  Future<int> getListExpensesOverallSum(User user) async {
    int overallSum = 0;

    var querySnapshot =
        await expenseCollection.doc(user.uid).collection("transaction").get();

    List<ExpenseTransaction> transactionList = [];

    transactionList = querySnapshot.docs
        .map((e) => ExpenseTransaction.fromJson(e.data()))
        .toList();

    transactionList.forEach((e) {
      if (e.type == "expense") {
        overallSum = overallSum - e.amount;
      } else if (e.type == "income") {
        overallSum = overallSum + e.amount;
      }
    });

    return overallSum;
  }

  Future<void> getListExpensesForMonth(User user) async {}
}
