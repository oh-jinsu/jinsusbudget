import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/bootstrapper.dart';

class SplashView extends View {
  final Bootstrapper bootstrapper;

  const SplashView({
    Key? key,
    required this.bootstrapper,
  }) : super(key: key);

  @override
  void onStart(BuildContext context) {
    super.onStart(context);

    bootstrapper.run();
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
