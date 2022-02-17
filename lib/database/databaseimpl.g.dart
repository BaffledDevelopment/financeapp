// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databaseimpl.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Transaction extends DataClass implements Insertable<Transaction> {
  final String type;
  final String day;
  final String month;
  final String memo;
  final int id;
  final int amount;
  final int categoryindex;
  Transaction(
      {required this.type,
      required this.day,
      required this.month,
      required this.memo,
      required this.id,
      required this.amount,
      required this.categoryindex});
  factory Transaction.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Transaction(
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      day: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}day'])!,
      month: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}month'])!,
      memo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}memo'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      categoryindex: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}categoryindex'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type'] = Variable<String>(type);
    map['day'] = Variable<String>(day);
    map['month'] = Variable<String>(month);
    map['memo'] = Variable<String>(memo);
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    map['categoryindex'] = Variable<int>(categoryindex);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      type: Value(type),
      day: Value(day),
      month: Value(month),
      memo: Value(memo),
      id: Value(id),
      amount: Value(amount),
      categoryindex: Value(categoryindex),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Transaction(
      type: serializer.fromJson<String>(json['type']),
      day: serializer.fromJson<String>(json['day']),
      month: serializer.fromJson<String>(json['month']),
      memo: serializer.fromJson<String>(json['memo']),
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      categoryindex: serializer.fromJson<int>(json['categoryindex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<String>(type),
      'day': serializer.toJson<String>(day),
      'month': serializer.toJson<String>(month),
      'memo': serializer.toJson<String>(memo),
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'categoryindex': serializer.toJson<int>(categoryindex),
    };
  }

  Transaction copyWith(
          {String? type,
          String? day,
          String? month,
          String? memo,
          int? id,
          int? amount,
          int? categoryindex}) =>
      Transaction(
        type: type ?? this.type,
        day: day ?? this.day,
        month: month ?? this.month,
        memo: memo ?? this.memo,
        id: id ?? this.id,
        amount: amount ?? this.amount,
        categoryindex: categoryindex ?? this.categoryindex,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('type: $type, ')
          ..write('day: $day, ')
          ..write('month: $month, ')
          ..write('memo: $memo, ')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('categoryindex: $categoryindex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(type, day, month, memo, id, amount, categoryindex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.type == this.type &&
          other.day == this.day &&
          other.month == this.month &&
          other.memo == this.memo &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.categoryindex == this.categoryindex);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> type;
  final Value<String> day;
  final Value<String> month;
  final Value<String> memo;
  final Value<int> id;
  final Value<int> amount;
  final Value<int> categoryindex;
  const TransactionsCompanion({
    this.type = const Value.absent(),
    this.day = const Value.absent(),
    this.month = const Value.absent(),
    this.memo = const Value.absent(),
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryindex = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String type,
    required String day,
    required String month,
    required String memo,
    this.id = const Value.absent(),
    required int amount,
    required int categoryindex,
  })  : type = Value(type),
        day = Value(day),
        month = Value(month),
        memo = Value(memo),
        amount = Value(amount),
        categoryindex = Value(categoryindex);
  static Insertable<Transaction> custom({
    Expression<String>? type,
    Expression<String>? day,
    Expression<String>? month,
    Expression<String>? memo,
    Expression<int>? id,
    Expression<int>? amount,
    Expression<int>? categoryindex,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (day != null) 'day': day,
      if (month != null) 'month': month,
      if (memo != null) 'memo': memo,
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (categoryindex != null) 'categoryindex': categoryindex,
    });
  }

  TransactionsCompanion copyWith(
      {Value<String>? type,
      Value<String>? day,
      Value<String>? month,
      Value<String>? memo,
      Value<int>? id,
      Value<int>? amount,
      Value<int>? categoryindex}) {
    return TransactionsCompanion(
      type: type ?? this.type,
      day: day ?? this.day,
      month: month ?? this.month,
      memo: memo ?? this.memo,
      id: id ?? this.id,
      amount: amount ?? this.amount,
      categoryindex: categoryindex ?? this.categoryindex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (month.present) {
      map['month'] = Variable<String>(month.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (categoryindex.present) {
      map['categoryindex'] = Variable<int>(categoryindex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('type: $type, ')
          ..write('day: $day, ')
          ..write('month: $month, ')
          ..write('memo: $memo, ')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('categoryindex: $categoryindex')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String?> day = GeneratedColumn<String?>(
      'day', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<String?> month = GeneratedColumn<String?>(
      'month', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String?> memo = GeneratedColumn<String?>(
      'memo', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int?> amount = GeneratedColumn<int?>(
      'amount', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _categoryindexMeta =
      const VerificationMeta('categoryindex');
  @override
  late final GeneratedColumn<int?> categoryindex = GeneratedColumn<int?>(
      'categoryindex', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [type, day, month, memo, id, amount, categoryindex];
  @override
  String get aliasedName => _alias ?? 'transactions';
  @override
  String get actualTableName => 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    } else if (isInserting) {
      context.missing(_memoMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('categoryindex')) {
      context.handle(
          _categoryindexMeta,
          categoryindex.isAcceptableOrUnknown(
              data['categoryindex']!, _categoryindexMeta));
    } else if (isInserting) {
      context.missing(_categoryindexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Transaction.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final TransactionDao transactionDao =
      TransactionDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [transactions];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TransactionDaoMixin on DatabaseAccessor<AppDatabase> {
  $TransactionsTable get transactions => attachedDatabase.transactions;
  Selectable<Transaction> getTransactionForMonth(String month) {
    return customSelect('SELECT * FROM transactions WHERE month = :month',
        variables: [
          Variable<String>(month)
        ],
        readsFrom: {
          transactions,
        }).map(transactions.mapFromRow);
  }

  Selectable<int> sumTheMoneyForMonth(String month, String type) {
    return customSelect(
        'SELECT SUM(amount) FROM transactions WHERE month = :month AND type = :type',
        variables: [
          Variable<String>(month),
          Variable<String>(type)
        ],
        readsFrom: {
          transactions,
        }).map((QueryRow row) => row.read<int>('SUM(amount)'));
  }

  Selectable<Transaction> getAllTransactionsForType(String month, String type) {
    return customSelect(
        'SELECT * FROM transactions WHERE month = :month AND type = :type',
        variables: [
          Variable<String>(month),
          Variable<String>(type)
        ],
        readsFrom: {
          transactions,
        }).map(transactions.mapFromRow);
  }
}
