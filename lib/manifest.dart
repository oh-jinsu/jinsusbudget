import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/dependencies.dart';
import 'package:jinsusbudget/controllers/home.dart';
import 'package:jinsusbudget/controllers/splash.dart';
import 'package:jinsusbudget/views/home.dart';
import 'package:jinsusbudget/views/splash.dart';

class AppManifest {
  final AppDependencies dependencies;

  AppManifest({
    required this.dependencies,
  });

  Map<String, View Function()> initialize() {
    return {
      "/": () => HomeView(
            navigator: HomeController(
              routeService: dependencies.service.route,
              dialogService: dependencies.service.dialog,
            ),
          ),
      "/splash": () => SplashView(
            controller: SplashController(
              routeService: dependencies.service.route,
              dialogService: dependencies.service.dialog,
              systemService: dependencies.service.system,
            ),
          ),
    };
  }
}
