import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/controllers/onboard.dart';
import 'package:jinsusbudget/theme/formatter.dart';

class OnboardView extends View {
  late final bool _isForStarters;

  final OnboardController onboardController;

  final FocusNode focusNode = FocusNode();

  final TextEditingController textEditingController = TextEditingController();

  OnboardView({
    Key? key,
    required this.onboardController,
  }) : super(key: key);

  @override
  void onCreate(BuildContext context) {
    super.onCreate(context);

    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    _isForStarters = arguments["isForStarters"] as bool;
  }

  @override
  void onStart(BuildContext context) {
    super.onStart(context);

    focusNode.requestFocus();
  }

  @override
  void onDestroy(BuildContext context) {
    onboardController.onDispose();

    super.onDestroy(context);
  }

  @override
  Widget render(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        appBar:
            AppBar(leading: _isForStarters ? Container() : const BackButton()),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "얼마로 하루를 살까요?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    AmountInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: "10000원",
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
                if (!_isForStarters) ...[
                  Row(
                    children: [
                      const SizedBox(width: 6.0),
                      const Icon(
                        Icons.campaign,
                        size: 20.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        "내일부터 적용됩니다.",
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.5,
                          color: Theme.of(context).textTheme.caption?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                ],
                ElevatedButton(
                  onPressed: () async {
                    final value = textEditingController.text
                        .replaceAll(",", "")
                        .replaceFirst("원", "");

                    final amount = int.tryParse(value);

                    if (amount == null) {
                      return;
                    }

                    onboardController.submit(amount);
                  },
                  child: Text(_isForStarters ? "시작하기" : "확인"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
