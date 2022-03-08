import 'package:flutter/material.dart';

class HomeLedgerHeader extends StatelessWidget {
  const HomeLedgerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "지출",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            size: 32.0,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }
}
