import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/controllers/onboard.dart';

class OnboardView extends View {
  final OnboardController controller;

  final FocusNode focusNode = FocusNode();

  final TextEditingController textEditingController = TextEditingController();

  OnboardView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  void onMount() {
    super.onMount();

    focusNode.requestFocus();
  }

  @override
  Widget render(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  "얼마로 하루를 살까요?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: "10000",
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.3),
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 50.0,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("시작하기"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
