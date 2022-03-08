import 'package:flutter/material.dart';
import 'package:jinsusbudget/components/app/container.dart';

class HomePocket extends StatelessWidget {
  const HomePocket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "오늘의 예산",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            "13,340원",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
