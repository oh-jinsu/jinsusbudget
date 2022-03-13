import 'package:flutter/widgets.dart';
import 'package:jinsusbudget/__core__/context.dart';

class RouteService {
  void pop() {
    Navigator.of(requireContext()).pop();
  }

  Future<void> navigateSplashToHome() async {
    await Navigator.of(requireContext()).pushNamedAndRemoveUntil(
      "/home",
      (route) => false,
    );
  }

  Future<void> navigateSplashToOnboard() async {
    await Navigator.of(requireContext()).pushNamed("/onboard", arguments: {
      "isForStarters": true,
    });
  }

  Future<void> navigateHomeToSettings() async {
    await Navigator.of(requireContext()).pushNamed(
      "/settings",
    );
  }

  Future<void> navigateSettingsToOnboard() async {
    await Navigator.of(requireContext()).pushNamed("/onboard", arguments: {
      "isForStarters": false,
    });
  }
}
