import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/components/app/container.dart';
import 'package:jinsusbudget/controllers/settings.dart';

class SettingsView extends View {
  final SettingsController settingsController;

  const SettingsView({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: AppContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  settingsController.resetBudget();
                },
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  minimumSize: const Size.fromHeight(0.0),
                ),
                child: Text(
                  "일일 예산 바꾸기",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
