import 'package:jinsusbudget/models/budget.dart';
import 'package:jinsusbudget/storages/local.dart';
import 'package:sqflite/sqflite.dart';

class BudgetRepository {
  final LocalStorage localStorage;

  static const _table = "budget";

  BudgetRepository({
    required this.localStorage,
  });

  Future<BudgetModel?> find() async {
    final result = await localStorage.query(
      _table,
      where: "id = ?",
      whereArgs: [1],
    );

    if (result.isEmpty) {
      return null;
    }

    return BudgetModel.fromMap(result[0]);
  }

  Future<BudgetModel> save({required int amount}) async {
    final budgetModel = BudgetModel(
      id: 1,
      amount: amount,
    );

    await localStorage.insert(
      _table,
      budgetModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return budgetModel;
  }
}
