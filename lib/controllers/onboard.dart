import 'package:jinsusbudget/__core__/controller.dart';
import 'package:jinsusbudget/repositories/config.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';

class OnboardController extends Controller {
  final RouteService routeService;
  final DialogService dialogService;
  final ConfigRepository configRepository;

  OnboardController({
    required this.routeService,
    required this.dialogService,
    required this.configRepository,
  });

  void submit(int amount) async {
    await configRepository.updateBudget(amount: amount);

    routeService.pop();
  }

  @override
  void onDispose() {}
}
