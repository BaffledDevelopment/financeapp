import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/services/icon_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/database_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:moor/moor.dart';

import '../locator.dart';
import '../models/transaction.dart';
import '../services/firebase_database_service.dart';

class DetailsModel extends BaseModel {
  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  final FirebaseDatabaseService _firebaseDatabaseService = locator<FirebaseDatabaseService>();
  final user = FirebaseAuth.instance.currentUser!;


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

  String getCategoryIconName(index, type) {
    if (type == 'income') {
      return _categoryIconService.incomeList.elementAt(index).name;
    } else {
      return _categoryIconService.expenseList.elementAt(index).name;
    }
  }

  Future<void> deleteTransacation(ExpenseTransaction transaction) async {

    return await _firebaseDatabaseService.deleteExpense(user, transaction);
  }
}
