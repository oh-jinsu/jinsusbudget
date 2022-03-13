import 'package:jinsusbudget/models/config.dart';
import 'package:jinsusbudget/storages/local.dart';

class ConfigMapper {
  static ConfigModel map(Map<String, dynamic> entity) {
    return ConfigModel(
      id: entity[LocalStorage.table.config.id],
      budget: entity[LocalStorage.table.config.budget],
      lastVisit: DateTime.fromMillisecondsSinceEpoch(
        entity[LocalStorage.table.config.lastVisited],
      ),
    );
  }
}
