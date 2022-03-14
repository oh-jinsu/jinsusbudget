import 'package:jinsusbudget/__core__/controller.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';

class SettingsController extends Controller {
  final RouteService routeService;
  final DialogService dialogService;

  SettingsController({
    required this.routeService,
    required this.dialogService,
  });

  void resetBudget() {
    routeService.navigateSettingsToOnboard();
  }

  void resetEverything() {
    routeService.navigateSettingsToSplash();
  }

  @override
  void onDispose() {}
}
