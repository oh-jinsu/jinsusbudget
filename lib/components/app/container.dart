import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const AppContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}
