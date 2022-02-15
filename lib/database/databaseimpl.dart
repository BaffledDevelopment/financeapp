import 'package:moor_flutter/moor_flutter.dart';
part 'databaseimpl.g.dart';

class Transactions extends Table {
  TextColumn get type => text()(); //expense /income
  TextColumn get day => text()();
  TextColumn get month => text()();
  TextColumn get assetpath => text()(); // asset path / photo
  TextColumn get memo => text()(); // asset path / photo
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();
}

@UseMoor(tables: [Transactions], daos: [TransactionDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: "db.sqlite", logStatements: true));

  int get schemaVersion => 1;
}

@UseDao(
  tables: [Transactions],
  queries: {
    // this method will be generated
    'getTransactionForMonth': 'SELECT * FROM transactions WHERE month = :month',
    'sumTheMoneyForMonth':
    'SELECT SUM(amount) FROM transactions WHERE month = :month AND type = :type',
    'getAllTransactionsForType':
    'SELECT * FROM transactions WHERE month = :month AND type = :type'
  },
)

class TransactionDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  TransactionDao(this.db) : super(db);

  Future<List<Transaction>> getAllTransactions() => select(transactions).get();

  Future insertTransaction(Transaction transaction) =>
      into(transactions).insert(transaction);

  Future updateTransaction(Transaction transaction) =>
      update(transactions).replace(transaction);

  Future deleteTransaction(Transaction transaction) =>
      delete(transactions).delete(transaction);
}