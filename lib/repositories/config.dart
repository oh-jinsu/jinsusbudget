import 'package:jinsusbudget/mappers/config.dart';
import 'package:jinsusbudget/models/config.dart';
import 'package:jinsusbudget/storages/local.dart';

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

    final result = ConfigMapper.map(entities[0]);

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

  Future<ConfigModel> updateLastVisit({
    required DateTime dateTime,
  }) async {
    await localStorage.update(
      LocalStorage.table.config.name,
      {
        LocalStorage.table.config.lastVisited: dateTime.millisecondsSinceEpoch,
      },
    );

    return find();
  }
}
