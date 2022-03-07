import 'package:jinsusbudget/repositories/budget.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';
import 'package:jinsusbudget/storages/local.dart';

class AppDependencies {
  final bool isProduction;

  AppDependencies({required this.isProduction});

  final service = ServiceDependencies();

  final storage = StorageDependencies();

  late final repository = RepositoryDependencies(
    storage: storage,
  );
}

class StorageDependencies {
  final local = LocalStorage();
}

class ServiceDependencies {
  final route = RouteService();

  final dialog = DialogService();
}

class RepositoryDependencies {
  final StorageDependencies _storage;

  RepositoryDependencies({required StorageDependencies storage})
      : _storage = storage;

  late final budget = BudgetRepository(
    localStorage: _storage.local,
  );
}
