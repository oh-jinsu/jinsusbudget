import 'package:jinsusbudget/models/budget.dart';
import 'package:jinsusbudget/storages/local.dart';
import 'package:sqflite/sqflite.dart';

class BudgetRepository {
  final LocalStorage localStorage;

  BudgetRepository({
    required this.localStorage,
  });

  Future<BudgetModel?> find() async {
    final result = await localStorage.query(
      LocalStorage.table.budget.name,
      where: "${LocalStorage.table.budget.id} = ?",
      whereArgs: [1],
    );

    if (result.isEmpty) {
      return null;
    }

    return BudgetModel.fromMap(result[0]);
  }

  Future<BudgetModel> save({required int amount}) async {
    await localStorage.insert(
      LocalStorage.table.budget.name,
      {
        LocalStorage.table.budget.id: 1,
        LocalStorage.table.budget.amount: amount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final result = await find();

    if (result == null) {
      throw Exception("저장한 예산을 찾지 못했습니다.");
    }

    return result;
  }
}
