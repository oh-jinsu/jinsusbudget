import 'package:jinsusbudget/__core__/controller.dart';
import 'package:jinsusbudget/repositories/budget.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';

class OnboardController extends Controller {
  final RouteService routeService;
  final DialogService dialogService;
  final BudgetRepository budgetRepository;

  OnboardController({
    required this.routeService,
    required this.dialogService,
    required this.budgetRepository,
  });

  void submit(int amount) async {
    await budgetRepository.save(amount: amount);

    routeService.pop();
  }

  @override
  void onDispose() {}
}
