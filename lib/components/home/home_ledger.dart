import 'package:flutter/material.dart';
import 'package:jinsusbudget/components/app/container.dart';
import 'package:jinsusbudget/components/home/home_ledger_item.dart';

class HomeLedger extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const HomeLedger({
    Key? key,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: 9 * 2 - 1,
        itemBuilder: (context, index) {
          if (index % 2 == 1) {
            return const Divider(
              height: 32.0,
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: HomeLedgerItem(
              label: "아이스 아메리카노",
              timestamp: DateTime.now(),
              amount: 5900,
            ),
          );
        },
      ),
    );
  }
}
