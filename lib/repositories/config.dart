import 'package:jinsusbudget/models/config.dart';
import 'package:jinsusbudget/storages/local.dart';

class ConfigModelMapper {
  static ConfigModel map(Map<String, dynamic> entity) {
    return ConfigModel(
      id: entity[LocalStorage.table.config.id],
      budget: entity[LocalStorage.table.config.budget],
    );
  }
}

class ConfigRepository {
  final LocalStorage localStorage;

  ConfigRepository({
    required this.localStorage,
  });

  Future<ConfigModel> find() async {
    final entities = await localStorage.query(
      LocalStorage.table.config.name,
      where: "${LocalStorage.table.config.id} = ?",
      whereArgs: [1],
    );

    final result = ConfigModelMapper.map(entities[0]);

    return result;
  }

  Future<ConfigModel> updateBudget({
    required int amount,
  }) async {
    await localStorage.update(
      LocalStorage.table.config.name,
      {
        LocalStorage.table.config.budget: amount,
      },
    );

    return find();
  }
}
