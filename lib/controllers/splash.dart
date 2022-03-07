import 'package:jinsusbudget/models/budget.dart';
import 'package:jinsusbudget/repositories/budget.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';
import 'package:jinsusbudget/storages/local.dart';

class SplashController {
  final RouteService routeService;
  final DialogService dialogService;
  final BudgetRepository budgetRepository;
  final LocalStorage localStorage;

  SplashController({
    required this.routeService,
    required this.dialogService,
    required this.budgetRepository,
    required this.localStorage,
  }) {
    _bootstrap();
  }

  void _bootstrap() async {
    await localStorage.initialize();

    await Future.delayed(const Duration(milliseconds: 500));

    await _getBudget();

    routeService.navigateSplashToHome();
  }

  Future<BudgetModel> _getBudget() async {
    final result = await budgetRepository.find();

    if (result == null) {
      await routeService.navigateSplashToOnboard();

      return _getBudget();
    }

    return result;
  }
}
