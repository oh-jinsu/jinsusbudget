import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jinsusbudget/controllers/home.dart';

class HomeLedgerHeader extends StatelessWidget {
  final HomeController homeController;

  const HomeLedgerHeader({
    Key? key,
    required this.homeController,
  }) : super(key: key);

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
          onPressed: () => showExpenditureDialog(context),
          icon: Icon(
            Icons.add,
            size: 32.0,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }

  void showExpenditureDialog(BuildContext context) async {
    final labelTextEditingController = TextEditingController();

    final labelFocusNode = FocusNode();

    final amountTextEditingController = TextEditingController();

    final amountFocusNode = FocusNode();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "새로운 지출",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "얼마를 썼나요?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountTextEditingController,
                      focusNode: amountFocusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        hintText: "금액",
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 0.0,
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    "원",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                ],
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "어디에 썼나요?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextField(
                controller: labelTextEditingController,
                focusNode: labelFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "용처",
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  border: OutlineInputBorder(
                    gapPadding: 0.0,
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(0.0),
              ),
              onPressed: () {
                final label = labelTextEditingController.text;

                if (label.isEmpty) {
                  return;
                }

                final amount = int.tryParse(amountTextEditingController.text);

                if (amount == null) {
                  return;
                }

                homeController.submitExpenditure(label: label, amount: amount);

                Navigator.of(context).pop();
              },
              child: const Text("확인"),
            ),
          ],
          contentPadding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 20.0,
            bottom: 20.0,
          ),
          actionsPadding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      },
    );
  }
}
