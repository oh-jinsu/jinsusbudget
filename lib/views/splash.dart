import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';

class SplashView extends View {
  const SplashView({
    Key? key,
  }) : super(key: key);

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
