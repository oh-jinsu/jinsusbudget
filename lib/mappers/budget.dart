import 'package:jinsusbudget/models/budget.dart';
import 'package:jinsusbudget/storages/local.dart';

class BudgetMapper {
  static BudgetModel map(Map<String, dynamic> entity) {
    return BudgetModel(
      id: entity[LocalStorage.table.budget.id],
      amount: entity[LocalStorage.table.budget.amount],
    );
  }
}
