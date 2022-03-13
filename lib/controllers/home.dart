import 'dart:async';

import 'package:jinsusbudget/__core__/controller.dart';
import 'package:jinsusbudget/models/budget.dart';
import 'package:jinsusbudget/models/config.dart';
import 'package:jinsusbudget/models/expenditure.dart';
import 'package:jinsusbudget/repositories/budget.dart';
import 'package:jinsusbudget/repositories/config.dart';
import 'package:jinsusbudget/repositories/expenditure.dart';
import 'package:jinsusbudget/repositories/piggy_bank.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';
import 'package:rxdart/subjects.dart';

class HomeController extends Controller {
  final RouteService routeService;
  final DialogService dialogService;
  final ConfigRepository configRepository;
  final BudgetRepository budgetRepository;
  final PiggyBankRepository piggyBankRepository;
  final ExpenditureRepository expenditureRepository;

  late final _today = BehaviorSubject<DateTime>.seeded(DateTime.now());
  Stream<DateTime> get today => _today.stream;

  late final _piggyBank = BehaviorSubject<int>(onListen: _initPiggyBank);
  Stream<int> get piggyBank => _piggyBank.stream;

  late final _budget = BehaviorSubject<int>(onListen: _initBudget);
  Stream<int> get budget => _budget.stream;

  late final _expenditures =
      BehaviorSubject<List<ExpenditureModel>>(onListen: _initExpenditures);
  Stream<List<ExpenditureModel>> get expenditures => _expenditures.stream;

  HomeController({
    required this.routeService,
    required this.dialogService,
    required this.configRepository,
    required this.budgetRepository,
    required this.piggyBankRepository,
    required this.expenditureRepository,
  });

  void _initPiggyBank() async {
    final model = await piggyBankRepository.find();

    if (model == null) {
      return;
    }

    final result = model.amount;

    _piggyBank.sink.add(result);
  }

  void _initBudget() async {
    final budget = await _getBudget();

    final result = budget.amount;

    _budget.sink.add(result);
  }

  Future<BudgetModel> _getBudget() async {
    final result = await budgetRepository.find(
      dateTime: _today.value,
    );

    if (result == null) {
      await _initForToday();

      return _getBudget();
    }

    return result;
  }

  void _initExpenditures() async {
    final models = await expenditureRepository.findAllForToday(
      dateTime: _today.value,
    );

    _expenditures.sink.add(models);
  }

  Future<void> _initForToday() async {
    final configModel = await configRepository.find();

    await Future.wait([
      _initBudgetForToday(configModel: configModel),
      _initPiggyBankForToday(configModel: configModel),
    ]);

    await configRepository.updateLastVisit(dateTime: _today.value);
  }

  Future<void> _initBudgetForToday({
    required ConfigModel configModel,
  }) async {
    final amount = configModel.budget;

    if (amount == null) {
      throw Exception();
    }

    await budgetRepository.save(
      amount: amount,
      dateTime: _today.value,
    );
  }

  Future<void> _initPiggyBankForToday({
    required ConfigModel configModel,
  }) async {
    final differenceInDays =
        _today.value.difference(configModel.lastVisit).inDays;

    final leftOvers = await Future.wait(List.generate(
      differenceInDays,
      (index) => index + 1,
    ).map((e) async {
      final at = _today.value.subtract(Duration(days: e));

      final result = await budgetRepository.find(dateTime: at);

      if (result == null) {
        final config = await configRepository.find();

        final budget = config.budget;

        if (budget == null) {
          throw Exception();
        }

        return budget;
      }

      return result.amount;
    }));

    if (leftOvers.isEmpty) {
      return;
    }

    final amount = leftOvers.reduce((value, element) => value + element);

    await piggyBankRepository.add(amount: amount);
  }

  void submitExpenditure({
    required String label,
    required int amount,
  }) async {
    final model = await expenditureRepository.save(
      label: label,
      amount: amount,
    );

    final leftover = _budget.value - amount;

    if (leftover < 0) {
      await budgetRepository.sub(
        amount: _budget.value,
        dateTime: _today.value,
      );

      await piggyBankRepository.sub(amount: -1 * leftover);

      _initPiggyBank();
    } else {
      await budgetRepository.sub(
        amount: amount,
        dateTime: _today.value,
      );
    }

    _initBudget();

    final array = _expenditures.value;

    final result = [...array, model];

    _expenditures.sink.add(result);
  }

  @override
  void onDispose() {
    _today.close();

    _piggyBank.close();

    _budget.close();

    _expenditures.close();
  }
}
