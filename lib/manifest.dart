import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/controllers/onboard.dart';
import 'package:jinsusbudget/dependencies.dart';
import 'package:jinsusbudget/controllers/home.dart';
import 'package:jinsusbudget/views/home.dart';
import 'package:jinsusbudget/views/onboard.dart';

class AppManifest {
  final AppDependencies dependencies;

  AppManifest({
    required this.dependencies,
  });

  Map<String, View Function()> initialize() {
    return {
      "/home": () => HomeView(
            controller: HomeController(
              routeService: dependencies.service.route,
              dialogService: dependencies.service.dialog,
              budgetRepository: dependencies.repository.budget,
              piggyBankRepository: dependencies.repository.piggyBank,
              expenditureRepository: dependencies.repository.expenditure,
            ),
          ),
      "/onboard": () => OnboardView(
            onboardController: OnboardController(
              routeService: dependencies.service.route,
              dialogService: dependencies.service.dialog,
              budgetRepository: dependencies.repository.budget,
            ),
          )
    };
  }
}
