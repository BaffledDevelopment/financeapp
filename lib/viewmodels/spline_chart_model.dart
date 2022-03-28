import 'package:finances/enum_viewstate.dart';
import 'package:finances/services/icon_service.dart';
import 'package:finances/ui/views/piechart_view.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../locator.dart';
import 'package:finances/models/expenses_chart_data.dart';

import '../models/transaction.dart';
import '../services/firebase_database_service.dart';

class SplineChartModel extends BaseModel {

  final user = FirebaseAuth.instance.currentUser!;
  FirebaseDatabaseService fdb_service = FirebaseDatabaseService();

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

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  List<ExpenseTransaction> transactions = List.empty();


  int selectedMonthIndex = 0;

  Map<String, double> dataMap = <String, double>{};

  String type = 'expense';

  List<String> types = ["Income", "Expense"];

  late List<ExpenseTransaction> dataList = <ExpenseTransaction>[];

  init(bool firstTime) async {
    if (firstTime) selectedMonthIndex = DateTime.now().month - 1;

    // dataList = _dataBaseService.getListOfExpenseSum();

    dataMap = await getDefaultDataMap();

    setState(ViewState.Busy);
    notifyListeners();

    // transactions = await _dataBaseService.getAllTransactionsForType(
    //     months.elementAt(selectedMonthIndex), type);



    print(dataMap.toString());

    setState(ViewState.Idle);
    notifyListeners();
  }

  // List<ExpensesChartData> expenses = getExpensesDataForEachMonth(transactions);

  changeSelectedMonth(int val) async {
    selectedMonthIndex = val;

    // transactions = await _dataBaseService.getAllTransactionsForType(
    //     months.elementAt(selectedMonthIndex), type);
    // clear old data
    // dataMap = getDefaultDataMap(transactions);
    //
    // transactions.forEach((element) {
    //   prepareDataMap(element);
    // });

    notifyListeners();
  }

  Future<List<ExpenseTransaction>?> getDefaultDataList() async {

    // List<ExpenseTransaction> aList = <ExpenseTransaction>{};

    dataList = (await fdb_service.transactionListFromSnapshot(user))!;

  }

  Future<Map<String, double>> getDefaultDataMap() async {

    Map<String, double> aMap = <String, double>{};

    var list = await fdb_service.transactionListFromSnapshot(user);

    list?.forEach((element) {
      aMap[element.month] = element.amount as double;
    });

    return aMap;
  }


    List<String> transactionsCategories = List.empty();



}
