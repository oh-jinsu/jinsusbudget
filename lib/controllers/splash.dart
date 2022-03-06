import 'package:jinsusbudget/services/system.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';

class SplashController {
  final RouteService routeService;
  final DialogService dialogService;
  final SystemService systemService;

  SplashController({
    required this.routeService,
    required this.dialogService,
    required this.systemService,
  }) {
    _bootstrap();
  }

  void _bootstrap() async {
    await systemService.bootstrap();

    routeService.navigateSplashToHome();
  }
}
