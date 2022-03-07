import 'package:jinsusbudget/repositories/budget.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';
import 'package:jinsusbudget/storages/local.dart';

class AppDependencies {
  final bool isProduction;

  AppDependencies({required this.isProduction});

  final StorageDependencies storage = StorageDependencies();

  late final RepositoryDependencies repository = RepositoryDependencies(
    storageDependencies: storage,
  );

  final ServiceDependencies service = ServiceDependencies();
}

class StorageDependencies {
  final LocalStorage local = LocalStorage();
}

class RepositoryDependencies {
  final StorageDependencies _storage;

  RepositoryDependencies({
    required StorageDependencies storageDependencies,
  }) : _storage = storageDependencies;

  late final BudgetRepository budget = BudgetRepository(
    localStorage: _storage.local,
  );
}

class ServiceDependencies {
  final RouteService route = RouteService();

  final DialogService dialog = DialogService();
}
