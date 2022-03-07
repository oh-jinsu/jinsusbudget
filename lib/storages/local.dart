import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage implements DatabaseExecutor {
  late final Database _db;

  Future<void> initialize() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), "jinsusbudget.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE budget(id INTEGER PRIMARY KEY, amount INTEGER)",
        );
      },
      version: 1,
    );
  }

  @override
  Batch batch() => _db.batch();

  @override
  Future<int> delete(String table, {String? where, List<Object?>? whereArgs}) =>
      _db.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );

  @override
  Future<void> execute(String sql, [List<Object?>? arguments]) async =>
      _db.execute(
        sql,
        arguments,
      );

  @override
  Future<int> insert(String table, Map<String, Object?> values,
          {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) =>
      _db.insert(
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
      _db.query(
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
      _db.rawDelete(sql, arguments);

  @override
  Future<int> rawInsert(String sql, [List<Object?>? arguments]) =>
      _db.rawInsert(
        sql,
        arguments,
      );

  @override
  Future<List<Map<String, Object?>>> rawQuery(String sql,
          [List<Object?>? arguments]) =>
      _db.rawQuery(
        sql,
        arguments,
      );

  @override
  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) =>
      _db.rawUpdate(
        sql,
        arguments,
      );

  @override
  Future<int> update(String table, Map<String, Object?> values,
          {String? where,
          List<Object?>? whereArgs,
          ConflictAlgorithm? conflictAlgorithm}) =>
      _db.update(
        table,
        values,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm,
      );
}
