import 'package:jinsusbudget/models/piggy_bank.dart';
import 'package:jinsusbudget/storages/local.dart';
import 'package:sqflite/sql.dart';

class PiggyBankMapper {
  static PiggyBankModel map(Map<String, dynamic> entity) {
    return PiggyBankModel(
      id: entity[LocalStorage.table.piggyBank.id],
      amount: entity[LocalStorage.table.piggyBank.amount],
    );
  }
}

class PiggyBankRepository {
  final LocalStorage localStorage;

  PiggyBankRepository({
    required this.localStorage,
  });

  Future<PiggyBankModel?> find() async {
    final result = await localStorage.query(
      LocalStorage.table.piggyBank.name,
      where: "${LocalStorage.table.piggyBank.id} = ?",
      whereArgs: [1],
    );

    if (result.isEmpty) {
      return null;
    }

    return PiggyBankMapper.map(result[0]);
  }

  Future<PiggyBankModel> zero() async {
    await localStorage.update(
      LocalStorage.table.piggyBank.name,
      {
        LocalStorage.table.piggyBank.amount: 0,
      },
      where: "${LocalStorage.table.piggyBank.id} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final result = await find();

    if (result == null) {
      throw Exception("여윳돈이 존재하지 않습니다.");
    }

    return result;
  }

  Future<PiggyBankModel> add({required int amount}) async {
    final piggyBank = await find();

    if (piggyBank == null) {
      throw Exception("여윳돈이 존재하지 않습니다.");
    }

    await localStorage.update(
      LocalStorage.table.piggyBank.name,
      {
        LocalStorage.table.piggyBank.amount: piggyBank.amount + amount,
      },
      where: "${LocalStorage.table.piggyBank.id} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final result = await find();

    if (result == null) {
      throw Exception("여윳돈이 존재하지 않습니다.");
    }

    return result;
  }

  Future<PiggyBankModel> sub({required int amount}) async {
    final piggyBank = await find();

    if (piggyBank == null) {
      throw Exception("여윳돈이 존재하지 않습니다.");
    }

    await localStorage.update(
      LocalStorage.table.piggyBank.name,
      {
        LocalStorage.table.piggyBank.amount: piggyBank.amount - amount,
      },
      where: "${LocalStorage.table.piggyBank.id} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final result = await find();

    if (result == null) {
      throw Exception("여윳돈이 존재하지 않습니다.");
    }

    return result;
  }
}
