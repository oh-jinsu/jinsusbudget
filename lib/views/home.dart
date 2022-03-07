import 'package:flutter/material.dart';
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: HomePiggyBank(),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                "3월 3일 월요일",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: HomePocket(),
            ),
            const SizedBox(height: 12.0),
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 8.0),
              child: HomeLedgerHeader(),
            ),
            const SizedBox(height: 2.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: HomeLedger(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
