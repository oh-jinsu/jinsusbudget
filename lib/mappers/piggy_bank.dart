import 'package:jinsusbudget/models/piggy_bank.dart';
import 'package:jinsusbudget/storages/local.dart';

class PiggyBankMapper {
  static PiggyBankModel map(Map<String, dynamic> entity) {
    return PiggyBankModel(
      id: entity[LocalStorage.table.piggyBank.id],
      amount: entity[LocalStorage.table.piggyBank.amount],
    );
  }
}
