import 'package:jinsusbudget/mappers/budget.dart';
import 'package:jinsusbudget/models/budget.dart';
import 'package:jinsusbudget/storages/local.dart';
import 'package:sqflite/sqflite.dart';

class BudgetRepository {
  final LocalStorage localStorage;

  BudgetRepository({
    required this.localStorage,
  });

  Future<BudgetModel?> find({
    required DateTime dateTime,
  }) async {
    final entities = await localStorage.query(
      LocalStorage.table.budget.name,
      where:
          "${LocalStorage.table.budget.year} = ? AND ${LocalStorage.table.budget.month} = ? AND ${LocalStorage.table.budget.day} = ?",
      whereArgs: [dateTime.year, dateTime.month + 1, dateTime.day],
    );

    if (entities.isEmpty) {
      return null;
    }

    return BudgetMapper.map(entities[0]);
  }

  Future<BudgetModel> save({
    required int amount,
    required DateTime dateTime,
  }) async {
    await localStorage.insert(
      LocalStorage.table.budget.name,
      {
        LocalStorage.table.budget.amount: amount,
        LocalStorage.table.budget.year: dateTime.year,
        LocalStorage.table.budget.month: dateTime.month + 1,
        LocalStorage.table.budget.day: dateTime.day,
      },
    );

    final result = await find(dateTime: dateTime);

    if (result == null) {
      throw Exception();
    }

    return result;
  }

  Future<BudgetModel> sub({
    required int amount,
    required DateTime dateTime,
  }) async {
    final budget = await find(dateTime: dateTime);

    if (budget == null) {
      throw Exception();
    }

    await localStorage.update(
      LocalStorage.table.budget.name,
      {
        LocalStorage.table.budget.amount: budget.amount - amount,
      },
      where:
          "${LocalStorage.table.budget.year} = ? AND ${LocalStorage.table.budget.month} = ? AND ${LocalStorage.table.budget.day} = ?",
      whereArgs: [dateTime.year, dateTime.month + 1, dateTime.day],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final result = await find(dateTime: dateTime);

    if (result == null) {
      throw Exception();
    }

    return result;
  }
}
