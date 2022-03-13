import 'package:jinsusbudget/mappers/expenditure.dart';
import 'package:jinsusbudget/models/expenditure.dart';
import 'package:jinsusbudget/storages/local.dart';
import 'package:sqflite/sql.dart';

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
        orderBy:
            "${LocalStorage.table.expenditure.hour} ASC, ${LocalStorage.table.expenditure.minute} ASC");

    return results.map((e) => ExpenditureMapper.map(e)).toList();
  }

  Future<ExpenditureModel> find({
    required int id,
  }) async {
    final result = await localStorage.query(
      LocalStorage.table.expenditure.name,
      where: "${LocalStorage.table.expenditure.id} = ?",
      whereArgs: [id],
    );

    return ExpenditureMapper.map(result[0]);
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
