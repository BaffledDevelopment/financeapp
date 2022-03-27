import 'package:finances/enum_viewstate.dart';
import 'package:finances/services/icon_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/database_service.dart';
import '../../locator.dart';
import 'package:finances/models/expenses_chart_data.dart';

class PieChartModel extends BaseModel {
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

  final DataBaseService _dataBaseService = locator<DataBaseService>();

  final CategoryIconService _categoryIconService =
      locator<CategoryIconService>();

  List<Transaction> transactions = List.empty();

  int selectedMonthIndex = 0;

  Map<String, double> dataMap = new Map<String, double>();

  String type = 'expense';

  List<String> types = ["Income", "Expense"];

  late List<ExpensesChartData> dataList;

  init(bool firstTime) async {
    if (firstTime) selectedMonthIndex = DateTime.now().month - 1;

    setState(ViewState.Busy);
    notifyListeners();

    print(dataMap.toString());

    setState(ViewState.Idle);
    notifyListeners();
  }

  // List<ExpensesChartData> expenses = getExpensesDataForEachMonth(transactions);

  changeSelectedMonth(int val) async {
    selectedMonthIndex = val;

    transactions = await _dataBaseService.getAllTransactionsForType(
        months.elementAt(selectedMonthIndex), type);
    // clear old data
    // dataMap = getDefaultDataMap(transactions);

    transactions.forEach((element) {
      // prepareDataMap(element);
    });

    notifyListeners();
  }

  int selectedItem = 1;

  void changeSelectedItem(int newItemIndex) {

    selectedItem = newItemIndex;

    print("I select item");
    print(selectedItem);
    print("***************");

    notifyListeners();
  }

}
