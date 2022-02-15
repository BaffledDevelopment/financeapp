import 'package:finances/database/databaseimpl.dart';

class DataBaseService {

  final AppDatabase _database = AppDatabase();

  getAllTransactions(String month) async {
    List<Transaction> allTrans = List<Transaction>.empty();

    TransactionDao transactionDao = _database.transactionDao;

    allTrans = await transactionDao.getTransactionForMonth(month).get();
    return allTrans;
  }

  Future deleteTransaction(Transaction transaction) async {
    return await _database.transactionDao.deleteTransaction(transaction);
  }

  Future insertTransaction(Transaction transaction) async {
    return await _database.transactionDao.insertTransaction(transaction);
  }

  Future updateTransaction(Transaction transaction) async {
    return await _database.transactionDao.updateTransaction(transaction);
  }

  getAllTransactionsForType(String month, String type) async {
    return await _database.transactionDao
        .getAllTransactionsForType(month, type)
        .get();
  }

  getExpenseSum(String month) async {
    List<int> list = await _database.transactionDao
        .sumTheMoneyForMonth(month, "expense")
        .get();

    int sumOfExpense = 0;

    if (list.isEmpty) {
      return 0;
    }

    for (var element in list) {

      sumOfExpense += element;
    }

    return sumOfExpense;
  }

  getIncomeSum(String month) async {
    List<int> list = await _database.transactionDao
        .sumTheMoneyForMonth(month, "income")
        .get();

    int sumOfIncome = 0;

    if (list.isEmpty) {
      return 0;
    }

    for (var element in list) {

      sumOfIncome += element;
    }

    return sumOfIncome;
  }

}