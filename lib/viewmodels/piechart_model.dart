import 'dart:ui';

import 'package:finances/enum_viewstate.dart';
import 'package:finances/services/icon_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../locator.dart';
import 'package:finances/models/expenses_chart_data.dart';

import '../models/transaction.dart';
import '../services/firebase_database_service.dart';
import '../ui/views/piechart_view.dart';

class PieChartModel extends BaseModel {

  Map<String, double> incomeMap = {};
  Map<String, double> expenseMap = {};

  late List<Expense> expense = [];

  int selectedItem = 1;
  int key = 0;

  var sumIncome = 0.0;
  var sumExpenses = 0.0;

  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseDatabaseService _firebaseDatabaseService = locator<FirebaseDatabaseService>();


  List<ExpenseTransaction> transactions = List.empty();

  int selectedMonthIndex = 0;

  String type = 'expense';

  List<String> types = ["Income", "Expense"];

  late List<ExpensesChartData> dataList;

  bool isSelected = false;

  List<Color> colorList = [
    Color.fromRGBO(82, 98, 255, 1),
    Color.fromRGBO(46, 198, 255, 1),
    Color.fromRGBO(123, 201, 82, 1),
    Color.fromRGBO(255, 171, 67, 1),
    Color.fromRGBO(252, 91, 57, 1),
    Color.fromRGBO(139, 135, 130, 1),
  ];


  List<String> months = [
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

  Map<int, String> incomeCategories = {
    0: "Salary",
    1: "Awards",
    2: "Grants",
    3: "Rental",
    4: "Investment",
    5: "Lottery",
  };

  Map<int, String> expenseCategories = {
    0: "Food",
    1: "Bills",
    2: "Transportaion",
    3: "Home",
    4: "Entertainment",
    5: "Shopping",
    6: "Clothing",
    7: "Insurance",
    8: "Telephone",
    9: "Health",
    10: "Sport",
    11: "Beauty",
    12: "Education",
    13: "Gift",
    14: "Pet",
  };

  Map<String, double> getcategoryIndexData() {


    incomeMap = {};
    expenseMap = {};

    for (var item in expense) {
      print(item.categoryIndex);

      // plot charts by amount, not by count of expenses of certain type

      // if (item.type == "income") {
      //   if (incomeMap
      //           .containsKey(incomeCategories[int.parse(item.categoryIndex)]) ==
      //       false) {
      //     incomeMap[
      //         incomeCategories[int.parse(item.categoryIndex)].toString()] = 1;
      //   } else {
      //     print("ENTRIES________ENTRIES");
      //     print(incomeMap.entries);
      //
      //     // в фаербейзе categoryIndex записан как Integer
      //     // в item оно вынужденно конвертируется в String из-за сериализации в Map<String, dynamic>
      //     // в справочной мапе incomeCategories Map<int, String> хранятся строки с пояснениями к индексу операции
      //     // в мапе incomeMap Map<String, double> хранится количество вхождений операций одного типа
      //     // для отрисовки сегментов piechart (принимают только Map<String, double>)
      //     // categoryIndex -> конверт в инт -> тянем название операции из справочной мапы
      //     // -> готов ключ для incomeMap и по нему тягаем циферьку :)
      //
      //     incomeMap[incomeCategories[int.parse(item.categoryIndex)]
      //         .toString()] = incomeMap[
      //             incomeCategories[int.parse(item.categoryIndex)].toString()]! +
      //         1;
      //   }
      // } else if (item.type == "expense") {
      //   if (expenseMap.containsKey(
      //           expenseCategories[int.parse(item.categoryIndex)].toString()) ==
      //       false) {
      //     expenseMap[
      //         expenseCategories[int.parse(item.categoryIndex)].toString()] = 1;
      //   } else {
      //     expenseMap[
      //             expenseCategories[int.parse(item.categoryIndex)].toString()] =
      //         expenseMap[expenseCategories[int.parse(item.categoryIndex)]
      //                 .toString()]! +
      //             1;
      //   }
      // }

      if (item.type == "income") {
        if (incomeMap
            .containsKey(incomeCategories[int.parse(item.categoryIndex)]) ==
            false) {
          incomeMap[incomeCategories[int.parse(item.categoryIndex)]
              .toString()] = (double.parse(item.amount.toString()));
        } else {
          print("ENTRIES________ENTRIES");
          print(incomeMap.entries);

          // в фаербейзе categoryIndex записан как Integer
          // в item оно вынужденно конвертируется в String из-за сериализации в Map<String, dynamic>
          // в справочной мапе incomeCategories Map<int, String> хранятся строки с пояснениями к индексу операции
          // в мапе incomeMap Map<String, double> хранится количество вхождений операций одного типа
          // для отрисовки сегментов piechart (принимают только Map<String, double>)
          // categoryIndex -> конверт в инт -> тянем название операции из справочной мапы
          // -> готов ключ для incomeMap и по нему тягаем циферьку :)

          incomeMap[incomeCategories[int.parse(item.categoryIndex)]
              .toString()] = incomeMap[
          incomeCategories[int.parse(item.categoryIndex)].toString()]! +
              (double.parse(item.amount.toString()));
        }
      } else if (item.type == "expense") {
        if (expenseMap.containsKey(
            expenseCategories[int.parse(item.categoryIndex)].toString()) ==
            false) {
          expenseMap[expenseCategories[int.parse(item.categoryIndex)]
              .toString()] = (double.parse(item.amount.toString()));
        } else {
          expenseMap[
          expenseCategories[int.parse(item.categoryIndex)].toString()] =
              expenseMap[expenseCategories[int.parse(item.categoryIndex)]
                  .toString()]! +
                  (double.parse(item.amount.toString()));
        }
      }
    }

    print("Income map entries");
    print(incomeMap.entries);

    print("Expense map entries");
    print(expenseMap.entries);

    sumExpenses = expenseMap.values.reduce((sum, element) => sum + element);
    sumIncome = incomeMap.values.reduce((sum, element) => sum + element);

    if (selectedItem == 1) {
      return incomeMap;
    } else {
      return expenseMap;
    }
  }



  init(bool firstTime) async {
    if (firstTime) selectedMonthIndex = DateTime.now().month - 1;

    setState(ViewState.Busy);

    // transactions = (await _firebaseDatabaseService.transactionListFromSnapshot(user))!;
    notifyListeners();

    setState(ViewState.Idle);
    notifyListeners();
  }

  changeSelectedMonth(int val) async {

    isSelected = true;

    selectedMonthIndex = val;

    setState(ViewState.Busy);

    transactions = await _firebaseDatabaseService.getListExpensesForMonth(user, months[selectedMonthIndex], type);

    setState(ViewState.Idle);

    notifyListeners();

  }

  Future<void> changeSelectedItem(int newItemIndex) async {

    isSelected = true;

    selectedItem = newItemIndex;

    print("I select item");
    print(selectedItem);
    print("***************");

    setState(ViewState.Busy);

    transactions = await _firebaseDatabaseService.getListExpensesForMonthWithIncome(user, months[selectedMonthIndex], type);

    setState(ViewState.Idle);

    notifyListeners();
  }
}
