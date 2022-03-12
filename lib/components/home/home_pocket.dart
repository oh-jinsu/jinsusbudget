import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jinsusbudget/components/app/container.dart';
import 'package:jinsusbudget/controllers/home.dart';

class HomePocket extends StatelessWidget {
  final HomeController homeController;

  const HomePocket({
    Key? key,
    required this.homeController,
  }) : super(key: key);

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
          StreamBuilder(
              stream: homeController.budget,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as int;

                  return Text(
                    "${NumberFormat("###,###,###,###").format(data)}원",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}
