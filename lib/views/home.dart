import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/controllers/home.dart';

class HomeView extends View {
  final HomeController navigator;

  const HomeView({
    Key? key,
    required this.navigator,
  }) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello, world!"),
      ),
    );
  }
}
