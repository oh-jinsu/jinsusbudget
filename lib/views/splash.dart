import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/bootstrapper.dart';

class SplashArguments {
  final bool reset;

  SplashArguments({
    required this.reset,
  });
}

class SplashView extends View<SplashArguments> {
  final Bootstrapper bootstrapper;

  SplashView({
    Key? key,
    required this.bootstrapper,
  }) : super(key: key);

  @override
  void onStart(BuildContext context) {
    super.onStart(context);

    final reset = _getReset();

    bootstrapper.run(reset: reset);
  }

  bool _getReset() {
    try {
      return arguments.reset;
    } on Error {
      return false;
    }
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
