import 'package:flutter/material.dart';
import 'package:jinsusbudget/controllers/onboard.dart';
import 'package:jinsusbudget/controllers/settings.dart';
import 'package:jinsusbudget/dependencies.dart';
import 'package:jinsusbudget/controllers/home.dart';
import 'package:jinsusbudget/views/home.dart';
import 'package:jinsusbudget/views/onboard.dart';
import 'package:jinsusbudget/views/settings.dart';

class AppManifest {
  final AppDependencies dependencies;

  AppManifest(this.dependencies);

  Map<String, Widget Function(BuildContext context)> get list {
    return {
      "/home": (context) => HomeView(
            controller: HomeController(
              routeService: dependencies.service.route,
              dialogService: dependencies.service.dialog,
              configRepository: dependencies.repository.config,
              budgetRepository: dependencies.repository.budget,
              piggyBankRepository: dependencies.repository.piggyBank,
              expenditureRepository: dependencies.repository.expenditure,
            ),
          ),
      "/onboard": (context) => OnboardView(
            onboardController: OnboardController(
              routeService: dependencies.service.route,
              dialogService: dependencies.service.dialog,
              configRepository: dependencies.repository.config,
            ),
          ),
      "/settings": (context) => SettingsView(
            settingsController: SettingsController(
              routeService: dependencies.service.route,
              dialogService: dependencies.service.dialog,
            ),
          )
    };
  }
}
