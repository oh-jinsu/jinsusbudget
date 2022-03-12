import 'package:flutter/material.dart';
import 'package:jinsusbudget/components/app/container.dart';
import 'package:jinsusbudget/components/home/home_ledger_item.dart';
import 'package:jinsusbudget/controllers/home.dart';
import 'package:jinsusbudget/models/expenditure.dart';

class HomeLedger extends StatelessWidget {
  final HomeController homeController;

  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const HomeLedger({
    Key? key,
    required this.homeController,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: StreamBuilder(
          stream: homeController.expenditures,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as List<ExpenditureModel>;

              if (data.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 16.0),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.payments,
                        size: 48.0,
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "오늘은 한 푼도 쓰지 않았어요.",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }

              ListView.builder(
                padding: const EdgeInsets.all(0.0),
                shrinkWrap: shrinkWrap,
                physics: physics,
                itemCount: data.length * 2 - 1,
                itemBuilder: (context, index) {
                  if (index % 2 == 1) {
                    return const Divider(
                      height: 0.0,
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: HomeLedgerItem(
                      label: data[index ~/ 2].label,
                      timestamp: data[index ~/ 2].timestamp,
                      amount: data[index ~/ 2].amount,
                    ),
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
