import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLedgerItem extends StatelessWidget {
  final String label;
  final DateTime timestamp;
  final int amount;

  const HomeLedgerItem({
    Key? key,
    required this.label,
    required this.timestamp,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                formatTimestamp(timestamp),
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(.7),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
        Text(
          "${formatAmount(amount)}원",
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  static String formatAmount(int amount) {
    return NumberFormat("###,###,###,###").format(amount);
  }

  static String formatTimestamp(DateTime timestamp) {
    final formatter = DateFormat("a h시 m분");

    return formatter
        .format(timestamp)
        .replaceFirst("PM", "오후")
        .replaceFirst("AM", "오전");
  }
}
