import 'package:flutter/material.dart';
import 'package:jinsusbudget/components/app/container.dart';

class HomePiggyBank extends StatelessWidget {
  const HomePiggyBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "여윳돈",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            "404,340원",
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
