import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorageTable {
  final budget = const BudgetTable();

  final piggyBank = const PiggyBankTable();

  final expenditure = const ExpenditureTable();

  const LocalStorageTable();
}

class BudgetTable {
  final name = "budget";

  final id = "id";

  final amount = "amount";

  const BudgetTable();
}

class PiggyBankTable {
  final name = "piggy_bank";

  final id = "id";

  final amount = "amount";

  const PiggyBankTable();
}

class ExpenditureTable {
  final name = "expenditure";

  final id = "id";

  final label = "label";

  final amount = "amount";

  final year = "year";

  final month = "month";

  final day = "day";

  final hour = "hour";

  final minute = "minute";

  const ExpenditureTable();
}

class LocalStorage implements DatabaseExecutor {
  Database? _database;

  Database get database => _database!;

  static const table = LocalStorageTable();

  Future<void> initialize() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "jinsusbudget_1.db"),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE ${table.budget.name}(${table.budget.id} INTEGER PRIMARY KEY, ${table.budget.amount} INTEGER)",
        );
        await db.execute(
          "CREATE TABLE ${table.piggyBank.name}(${table.piggyBank.id} INTEGER PRIMARY KEY, ${table.piggyBank.amount} INTEGER)",
        );
        db.rawInsert(
          "INSERT INTO ${table.piggyBank.name}(${table.piggyBank.id}, ${table.piggyBank.amount}) VALUES(1, 0)",
        );
        db.execute(
          "CREATE TABLE ${table.expenditure.name}(${table.expenditure.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${table.expenditure.label} TEXT NOT NULL, ${table.expenditure.amount} INTEGER NOT NULL, ${table.expenditure.year} INTEGER NOT NULL, ${table.expenditure.month} INTEGER NOT NULL, ${table.expenditure.day} INTEGER NOT NULL, ${table.expenditure.hour} INTEGER NOT NULL, ${table.expenditure.minute} INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }

  @override
  Batch batch() => database.batch();

  @override
  Future<int> delete(String table, {String? where, List<Object?>? whereArgs}) =>
      database.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );

  @override
  Future<void> execute(String sql, [List<Object?>? arguments]) async =>
      database.execute(
        sql,
        arguments,
      );

  @override
  Future<int> insert(String table, Map<String, Object?> values,
          {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) =>
      database.insert(
        table,
        values,
        nullColumnHack: nullColumnHack,
        conflictAlgorithm: conflictAlgorithm,
      );

  @override
  Future<List<Map<String, Object?>>> query(String table,
          {bool? distinct,
          List<String>? columns,
          String? where,
          List<Object?>? whereArgs,
          String? groupBy,
          String? having,
          String? orderBy,
          int? limit,
          int? offset}) =>
      database.query(
        table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );

  @override
  Future<int> rawDelete(String sql, [List<Object?>? arguments]) =>
      database.rawDelete(sql, arguments);

  @override
  Future<int> rawInsert(String sql, [List<Object?>? arguments]) =>
      database.rawInsert(
        sql,
        arguments,
      );

  @override
  Future<List<Map<String, Object?>>> rawQuery(String sql,
          [List<Object?>? arguments]) =>
      database.rawQuery(
        sql,
        arguments,
      );

  @override
  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) =>
      database.rawUpdate(
        sql,
        arguments,
      );

  @override
  Future<int> update(String table, Map<String, Object?> values,
          {String? where,
          List<Object?>? whereArgs,
          ConflictAlgorithm? conflictAlgorithm}) =>
      database.update(
        table,
        values,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm,
      );
}
