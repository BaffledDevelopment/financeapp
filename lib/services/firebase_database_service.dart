import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseDatabaseService {

  FirebaseDatabaseService();

  final CollectionReference expenseCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> updateExpenses(String type,
      String day,
      String month,
      int amount,
      String note,
      int categoryIndex,) async {
    // Todo FILL THIS
  }

  Future<void> addExpenses({
    required User user,
    required String type,
    required String day,
    required String month,
    required int amount,
    required String note,
    required int categoryIndex,}) async {
    await expenseCollection.doc(user.uid).collection("transaction").add({
      "type": type,
      "day": day,
      "month": month,
      "amount": amount,
      "note": note,
      "categoryIndex": categoryIndex
    });
  }

  Future<void> getExpenses(User user) async {    var userDoc =
  await expenseCollection.where('email', isEqualTo: user.email).get();

  // var users = expenseCollection.doc(user.uid).collection("").where('email', isEqualTo: user.email).get();

  userDoc.docs.forEach((element) {
    print(element.data());
  });}

  Future<void> deleteExpense(User user) async {

  }

  Future<void> updateExpense(User user) async {}

}
