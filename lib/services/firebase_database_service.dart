import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseDatabaseService {

  FirebaseDatabaseService();

  final CollectionReference expenseCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> updateExpenses() async {}

  Future<void> addExpenses() async {}


  Future<void> getExpenses(User user) async {}

  Future<void> deleteExpense(User user) async {}

  Future<void> updateExpense(User user) async {}

}
