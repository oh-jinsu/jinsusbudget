import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jinsusbudget/__core__/view.dart';
import 'package:jinsusbudget/components/home/home_ledger_header.dart';
import 'package:jinsusbudget/components/home/home_pocket.dart';
import 'package:jinsusbudget/components/home/home_ledger.dart';
import 'package:jinsusbudget/components/home/home_piggy_bank.dart';
import 'package:jinsusbudget/controllers/home.dart';

class HomeView extends View {
  final HomeController controller;

  const HomeView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  void onUnmount() {
    controller.onDispose();

    super.onUnmount();
  }

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HomePiggyBank(
                homeController: controller,
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: StreamBuilder(
                stream: controller.today,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as DateTime;

                    return Text(
                      DateFormat("yyyy년 M월 d일").format(data),
                      style: Theme.of(context).textTheme.headlineSmall,
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HomePocket(
                homeController: controller,
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 10.0),
              child: HomeLedgerHeader(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: HomeLedger(
                homeController: controller,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
