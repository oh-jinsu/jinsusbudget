import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jinsusbudget/components/app/container.dart';
import 'package:jinsusbudget/controllers/home.dart';

class HomePiggyBank extends StatelessWidget {
  final HomeController homeController;

  const HomePiggyBank({
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
            "여윳돈",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 8.0,
          ),
          StreamBuilder(
            stream: homeController.piggyBank,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as int;

                return Text(
                  "${NumberFormat("###,###,###,###").format(data)}원",
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Color(0xff7d7d7d),
                    fontWeight: FontWeight.bold,
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
