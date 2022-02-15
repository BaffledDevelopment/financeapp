import 'package:finances/database/databaseimpl.dart';
import 'package:finances/services/auth_service.dart';
import 'package:finances/services/database_service.dart';
import 'package:finances/viewmodels/base_model.dart';

import 'package:finances/locator.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();

  final DataBaseService _dataBaseService =
    locator<DataBaseService>();

  late List<Transaction> transactions;
  bool isCollapsed = false;
  late String appBarTitle; // name of seklected month
  late String selectedYear;
  late int selectedMonthIndex; // list below

  List months = [
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

  monthClicked(String clickedMonth) {
    selectedMonthIndex = months.indexOf(clickedMonth);

    appBarTitle = clickedMonth;

    titleClicked();
  }

  titleClicked() {
    isCollapsed = !isCollapsed;
    notifyListeners();
  }

}