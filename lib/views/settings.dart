import 'package:flutter/material.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/components/app/container.dart';
import 'package:jinsusbudget/components/settings/menu_button.dart';
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
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsMenuButton(
                label: "일일 예산 바꾸기",
                onPressed: () {
                  settingsController.resetBudget();
                },
              ),
              const Divider(height: 0.0),
              SettingsMenuButton(
                label: "초기화하기",
                onPressed: () {
                  showResestAlertDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showResestAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "경고",
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          content: const Text(
            "애플리케이션이 처음 상태로 돌아가요. 정말 초기화할까요?",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "취소",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(.7),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                settingsController.resetEverything();
              },
              child: Text(
                "초기화",
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      },
    );
  }
}
