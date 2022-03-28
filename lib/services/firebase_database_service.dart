import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

import '../models/transaction.dart';

class FirebaseDatabaseService {
  FirebaseDatabaseService();

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('users');

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
        .collection("transaction")
        .where("id", isEqualTo: id)
        .get();

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

  }

  Future<List<ExpenseTransaction>?> transactionListFromSnapshot(
      User user) async {
    try {
      List<ExpenseTransaction> transactionList = [];

      var querySnapshot =
          await expenseCollection.doc(user.uid).collection("transaction").get();

      transactionList = querySnapshot.docs
          .map((e) => ExpenseTransaction.fromJson(e.data()))
          .toList();

      return transactionList;
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteExpense(User user, ExpenseTransaction transaction) async {
    print("___________________");

    print(transaction.id);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transaction')
        .doc(transaction.id)
        .delete();
  }

  Future<void> updateExpense(User user, ExpenseTransaction transaction,
      String note, int amount) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('transaction')
        .doc(transaction.id)
        .update({
      'type': transaction.type,
      'day': transaction.day,
      'month': transaction.month,
      'note': note,
      'id': transaction.id,
      'amount': amount,
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

    print("*********************");
    print(querySnapshot.toString());
    print("________________________");

    List<ExpenseTransaction> transactionList = [];

    transactionList = querySnapshot.docs
        .map((e) => ExpenseTransaction.fromJson(e.data()))
        .toList();

    transactionList.forEach((e) {
      print(e.toJson());
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

  Future<List<ExpenseTransaction>> getListExpensesForMonthWithIncome(
      User user, String month, String type) async {
    var querySnapshot =
        await expenseCollection.doc(user.uid).collection("transaction").get();

    List<ExpenseTransaction> transactionList = [];

    List<ExpenseTransaction> returnTransactionList = [];

    transactionList = querySnapshot.docs
        .map((e) => ExpenseTransaction.fromJson(e.data()))
        .toList();

    if (type == "income") {
      transactionList.forEach((e) {
        if (e.month == month && e.type == "income") {
          returnTransactionList.add(e);
        }
      });
    } else {
      transactionList.forEach((e) {
        if (e.month == month && e.type == "expense") {
          returnTransactionList.add(e);
        }
      });
    }

    return returnTransactionList;
  }

  Future<List<ExpenseTransaction>> getListExpensesForMonth(
      User user, String month, String type) async {
    var querySnapshot =
    await expenseCollection.doc(user.uid).collection("transaction").get();

    List<ExpenseTransaction> transactionList = [];

    List<ExpenseTransaction> returnTransactionList = [];

    transactionList = querySnapshot.docs
        .map((e) => ExpenseTransaction.fromJson(e.data()))
        .toList();

    if (type == "income") {
      transactionList.forEach((e) {
        if (e.month == month) {
          returnTransactionList.add(e);
        }
      });
    } else {
      transactionList.forEach((e) {
        if (e.month == month) {
          returnTransactionList.add(e);
        }
      });
    }

    return returnTransactionList;
  }

  Future<void> saveDatabaseToCSVFile(User user) async {
    List<List<dynamic>> rows = <List<dynamic>>[];

    final String? directory = (await getExternalStorageDirectory())?.path;
    final path = "$directory/csv-${DateTime.now()}.csv";

    var querySnapshot =
        await expenseCollection.doc(user.uid).collection("transaction").get();

    rows.add(["amount", "categoryIndex", "day", "id", "month", "note", "type"]);

    if (querySnapshot.docs != null) {
      for (int i = 0; i < querySnapshot.size; i++) {
        List<dynamic> row = <dynamic>[];
        row.add(querySnapshot.docs[i]["amount"]);
        row.add(querySnapshot.docs[i]["categoryIndex"]);
        row.add(querySnapshot.docs[i]["day"]);
        row.add(querySnapshot.docs[i]["id"]);
        row.add(querySnapshot.docs[i]["month"]);
        row.add(querySnapshot.docs[i]["type"]);
        print(rows.toList());
        rows.add(row);
      }

      final File file = await File(path).create();

      String? dir = (await getExternalStorageDirectory())?.absolute.path;

      dir = "/storage/emulated/0/Download/filename.csv";
      String fileDir = "$dir";

      String csv = const ListToCsvConverter().convert(rows);

      try {
        file.writeAsString(csv);
      } catch (e) {
        print(e);
      }
      print(directory);
    }
  }
}
