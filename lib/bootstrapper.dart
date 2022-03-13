import 'package:jinsusbudget/dependencies.dart';
import 'package:jinsusbudget/environment.dart';

class Bootstrapper {
  final AppDependencies dependencies;

  Bootstrapper({
    required this.dependencies,
  });

  void run() async {
    await Environment.initialize();

    await dependencies.storage.local.initialize();

    await Future.delayed(const Duration(milliseconds: 500));

    await _getBudget();

    dependencies.service.route.navigateSplashToHome();
  }

  Future<void> _getBudget() async {
    final result = await dependencies.repository.budget.find();

    if (result == null) {
      await dependencies.service.route.navigateSplashToOnboard();

      return _getBudget();
    }
  }
}
