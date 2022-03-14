import 'package:jinsusbudget/dependencies.dart';
import 'package:jinsusbudget/environment.dart';

class Bootstrapper {
  final AppDependencies dependencies;

  Bootstrapper({
    required this.dependencies,
  });

  void run({
    bool reset = false,
  }) async {
    final from = DateTime.now();

    if (reset) {
      await _restart();
    } else {
      await _coldstart();
    }

    final elapsed = from.difference(DateTime.now());

    await Future.delayed(const Duration(milliseconds: 1000) + elapsed);

    await _setBudget();

    _finish();
  }

  Future<void> _restart() async {
    await dependencies.storage.local.reset();
  }

  Future<void> _coldstart() async {
    await Environment.initialize();

    await dependencies.storage.local.open();
  }

  Future<void> _setBudget() async {
    final result = await dependencies.repository.config.find();

    if (result.budget == null) {
      await dependencies.service.route.navigateSplashToOnboard();

      return _setBudget();
    }
  }

  void _finish() {
    dependencies.service.route.navigateSplashToHome();
  }
}
