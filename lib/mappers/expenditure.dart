import 'package:jinsusbudget/models/expenditure.dart';
import 'package:jinsusbudget/storages/local.dart';

class ExpenditureMapper {
  static ExpenditureModel map(Map<String, dynamic> map) {
    final id = map[LocalStorage.table.expenditure.id] as int;
    final label = map[LocalStorage.table.expenditure.label] as String;
    final amount = map[LocalStorage.table.expenditure.amount] as int;
    final year = map[LocalStorage.table.expenditure.year] as int;
    final month = map[LocalStorage.table.expenditure.month] as int;
    final day = map[LocalStorage.table.expenditure.day] as int;
    final hour = map[LocalStorage.table.expenditure.hour] as int;
    final minute = map[LocalStorage.table.expenditure.minute] as int;

    final formattedDateTime =
        "$year${month.toString().padLeft(2, "0")}${day.toString().padLeft(2, "0")}T${hour.toString().padLeft(2, "0")}${minute.toString().padLeft(2, "0")}00";

    return ExpenditureModel(
      id: id,
      label: label,
      amount: amount,
      timestamp: DateTime.parse(formattedDateTime),
    );
  }
}
