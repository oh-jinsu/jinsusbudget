import 'dart:math';

import 'package:jinsusbudget/models/expenditure.dart';
import 'package:jinsusbudget/storages/local.dart';
import 'package:sqflite/sql.dart';

class ExpenditureModelMapper {
  static ExpenditureModel map(Map<String, dynamic> map) {
    final id = map["id"] as int;
    final label = map["label"] as String;
    final amount = map["amount"] as int;
    final year = map["year"] as int;
    final month = map["month"] as int;
    final day = map["day"] as int;
    final hour = map["hour"] as int;
    final minute = map["minute"] as int;

    return ExpenditureModel(
      id: id,
      label: label,
      amount: amount,
      timestamp: DateTime.parse((pow(10, 2) * minute +
              pow(10, 4) * hour +
              pow(10, 6) * day +
              pow(10, 8) * month +
              pow(10, 10) * year)
          .toString()),
    );
  }
}

class ExpenditureRepository {
  final LocalStorage localStorage;

  ExpenditureRepository({
    required this.localStorage,
  });

  Future<List<ExpenditureModel>> findAllForToday({
    required DateTime dateTime,
  }) async {
    final results = await localStorage.query(
      LocalStorage.table.expenditure.name,
      where:
          "${LocalStorage.table.expenditure.year} = ? AND ${LocalStorage.table.expenditure.month} = ? AND ${LocalStorage.table.expenditure.day} = ?",
      whereArgs: [dateTime.year, dateTime.month + 1, dateTime.day],
    );

    return results.map((e) => ExpenditureModelMapper.map(e)).toList();
  }

  Future<ExpenditureModel> find({
    required int id,
  }) async {
    final result = await localStorage.query(
      LocalStorage.table.expenditure.name,
      where: "${LocalStorage.table.expenditure.id} = ?",
      whereArgs: [id],
    );

    return ExpenditureModelMapper.map(result[0]);
  }

  Future<ExpenditureModel> save({
    required String label,
    required int amount,
  }) async {
    final date = DateTime.now();

    final year = date.year;

    final month = date.month + 1;

    final day = date.day;

    final hour = date.hour;

    final minute = date.minute;

    final id = await localStorage.insert(
      LocalStorage.table.expenditure.name,
      {
        LocalStorage.table.expenditure.label: label,
        LocalStorage.table.expenditure.amount: amount,
        LocalStorage.table.expenditure.year: year,
        LocalStorage.table.expenditure.month: month,
        LocalStorage.table.expenditure.day: day,
        LocalStorage.table.expenditure.hour: hour,
        LocalStorage.table.expenditure.minute: minute,
      },
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    return await find(id: id);
  }

  Future<ExpenditureModel> update({
    required int id,
    int? label,
    String? amount,
  }) async {
    final map = <String, dynamic>{};

    if (label != null) {
      map[LocalStorage.table.expenditure.label] = label;
    }

    if (amount != null) {
      map[LocalStorage.table.expenditure.amount] = amount;
    }

    await localStorage.update(
      LocalStorage.table.expenditure.name,
      map,
      where: "${LocalStorage.table.expenditure.id} = ?",
      whereArgs: [id],
    );

    return await find(id: id);
  }

  Future<void> delete({
    required int id,
  }) async {
    await localStorage.delete(
      LocalStorage.table.expenditure.name,
      where: "${LocalStorage.table.expenditure.id} = ?",
      whereArgs: [id],
    );
  }
}
