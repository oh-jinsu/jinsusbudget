import 'package:flutter/widgets.dart';
import 'package:jinsusbudget/__core__/context.dart';
import 'package:jinsusbudget/views/home.dart';
import 'package:jinsusbudget/views/onboard.dart';
import 'package:jinsusbudget/views/settings.dart';
import 'package:jinsusbudget/views/splash.dart';

class RouteService {
  void pop() {
    Navigator.of(requireContext()).pop();
  }

  Future<void> navigateSplashToHome() async {
    await Navigator.of(requireContext()).pushNamedAndRemoveUntil(
      "/home",
      (route) => false,
      arguments: HomeArguments(),
    );
  }

  Future<void> navigateSplashToOnboard() async {
    await Navigator.of(requireContext()).pushNamed(
      "/onboard",
      arguments: OnboardArguments(
        forStarter: true,
      ),
    );
  }

  Future<void> navigateHomeToSettings() async {
    await Navigator.of(requireContext()).pushNamed(
      "/settings",
      arguments: SettingsArguments(),
    );
  }

  Future<void> navigateSettingsToOnboard() async {
    await Navigator.of(requireContext()).pushNamed(
      "/onboard",
      arguments: OnboardArguments(
        forStarter: false,
      ),
    );
  }

  Future<void> navigateSettingsToSplash() async {
    await Navigator.of(requireContext()).pushNamed(
      "/splash",
      arguments: SplashArguments(
        reset: true,
      ),
    );
  }
}
