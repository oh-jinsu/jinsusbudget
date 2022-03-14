import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/bootstrapper.dart';

class SplashArguments {
  bool reset = false;
}

class SplashView extends View {
  final arguments = SplashArguments();

  final Bootstrapper bootstrapper;

  SplashView({
    Key? key,
    required this.bootstrapper,
  }) : super(key: key);

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map?;

    arguments.reset = args?["reset"] ?? false;
  }

  @override
  void onStart(BuildContext context) {
    super.onStart(context);

    bootstrapper.run(reset: arguments.reset);
  }

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "진수의 가계부",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
