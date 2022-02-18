import 'package:finances/services/icon_service.dart';

import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/database_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:moor/moor.dart';

import '../locator.dart';


class DetailsModel extends BaseModel {
  final CategoryIconService _categoryIconService =
  locator<CategoryIconService>();

  final DataBaseService _databaseService =
  locator<DataBaseService>();

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

  Future deleteTransacation(Transaction transaction) async {

    final newTransaction = TransactionsCompanion(
        type: Value.ofNullable(transaction.type),
        day: Value.ofNullable(transaction.day),
        month: Value.ofNullable(transaction.month),
        memo: Value.ofNullable(transaction.memo),
        amount: Value.ofNullable(transaction.amount),
        categoryindex: Value.ofNullable(transaction.categoryindex));
    // delet it!

    return await _databaseService.deleteTransaction(newTransaction);
  }


}