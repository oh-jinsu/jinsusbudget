import 'package:jinsusbudget/models/budget.dart';
import 'package:jinsusbudget/storages/local.dart';
import 'package:sqflite/sqflite.dart';

class BudgetMapper {
  static BudgetModel map(Map<String, dynamic> entity) {
    return BudgetModel(
      id: entity[LocalStorage.table.budget.id],
      amount: entity[LocalStorage.table.budget.amount],
    );
  }
}

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

    return BudgetMapper.map(result[0]);
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

  Future<BudgetModel> sub({required int amount}) async {
    final budget = await find();

    if (budget == null) {
      throw Exception("예산이 존재하지 않습니다.");
    }

    await localStorage.update(
      LocalStorage.table.budget.name,
      {
        LocalStorage.table.budget.amount: budget.amount - amount,
      },
      where: "${LocalStorage.table.budget.id} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final result = await find();

    if (result == null) {
      throw Exception("예산이 존재하지 않습니다.");
    }

    return result;
  }
}
