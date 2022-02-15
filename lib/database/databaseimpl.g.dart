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
  final String assetpath;
  final String memo;
  final int id;
  final int amount;
  Transaction(
      {required this.type,
      required this.day,
      required this.month,
      required this.assetpath,
      required this.memo,
      required this.id,
      required this.amount});
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
      assetpath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}assetpath'])!,
      memo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}memo'])!,
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      amount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type'] = Variable<String>(type);
    map['day'] = Variable<String>(day);
    map['month'] = Variable<String>(month);
    map['assetpath'] = Variable<String>(assetpath);
    map['memo'] = Variable<String>(memo);
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      type: Value(type),
      day: Value(day),
      month: Value(month),
      assetpath: Value(assetpath),
      memo: Value(memo),
      id: Value(id),
      amount: Value(amount),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Transaction(
      type: serializer.fromJson<String>(json['type']),
      day: serializer.fromJson<String>(json['day']),
      month: serializer.fromJson<String>(json['month']),
      assetpath: serializer.fromJson<String>(json['assetpath']),
      memo: serializer.fromJson<String>(json['memo']),
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<String>(type),
      'day': serializer.toJson<String>(day),
      'month': serializer.toJson<String>(month),
      'assetpath': serializer.toJson<String>(assetpath),
      'memo': serializer.toJson<String>(memo),
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
    };
  }

  Transaction copyWith(
          {String? type,
          String? day,
          String? month,
          String? assetpath,
          String? memo,
          int? id,
          int? amount}) =>
      Transaction(
        type: type ?? this.type,
        day: day ?? this.day,
        month: month ?? this.month,
        assetpath: assetpath ?? this.assetpath,
        memo: memo ?? this.memo,
        id: id ?? this.id,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('type: $type, ')
          ..write('day: $day, ')
          ..write('month: $month, ')
          ..write('assetpath: $assetpath, ')
          ..write('memo: $memo, ')
          ..write('id: $id, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(type, day, month, assetpath, memo, id, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.type == this.type &&
          other.day == this.day &&
          other.month == this.month &&
          other.assetpath == this.assetpath &&
          other.memo == this.memo &&
          other.id == this.id &&
          other.amount == this.amount);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> type;
  final Value<String> day;
  final Value<String> month;
  final Value<String> assetpath;
  final Value<String> memo;
  final Value<int> id;
  final Value<int> amount;
  const TransactionsCompanion({
    this.type = const Value.absent(),
    this.day = const Value.absent(),
    this.month = const Value.absent(),
    this.assetpath = const Value.absent(),
    this.memo = const Value.absent(),
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String type,
    required String day,
    required String month,
    required String assetpath,
    required String memo,
    this.id = const Value.absent(),
    required int amount,
  })  : type = Value(type),
        day = Value(day),
        month = Value(month),
        assetpath = Value(assetpath),
        memo = Value(memo),
        amount = Value(amount);
  static Insertable<Transaction> custom({
    Expression<String>? type,
    Expression<String>? day,
    Expression<String>? month,
    Expression<String>? assetpath,
    Expression<String>? memo,
    Expression<int>? id,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (day != null) 'day': day,
      if (month != null) 'month': month,
      if (assetpath != null) 'assetpath': assetpath,
      if (memo != null) 'memo': memo,
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
    });
  }

  TransactionsCompanion copyWith(
      {Value<String>? type,
      Value<String>? day,
      Value<String>? month,
      Value<String>? assetpath,
      Value<String>? memo,
      Value<int>? id,
      Value<int>? amount}) {
    return TransactionsCompanion(
      type: type ?? this.type,
      day: day ?? this.day,
      month: month ?? this.month,
      assetpath: assetpath ?? this.assetpath,
      memo: memo ?? this.memo,
      id: id ?? this.id,
      amount: amount ?? this.amount,
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
    if (assetpath.present) {
      map['assetpath'] = Variable<String>(assetpath.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('type: $type, ')
          ..write('day: $day, ')
          ..write('month: $month, ')
          ..write('assetpath: $assetpath, ')
          ..write('memo: $memo, ')
          ..write('id: $id, ')
          ..write('amount: $amount')
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
  final VerificationMeta _assetpathMeta = const VerificationMeta('assetpath');
  @override
  late final GeneratedColumn<String?> assetpath = GeneratedColumn<String?>(
      'assetpath', aliasedName, false,
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
  @override
  List<GeneratedColumn> get $columns =>
      [type, day, month, assetpath, memo, id, amount];
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
    if (data.containsKey('assetpath')) {
      context.handle(_assetpathMeta,
          assetpath.isAcceptableOrUnknown(data['assetpath']!, _assetpathMeta));
    } else if (isInserting) {
      context.missing(_assetpathMeta);
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