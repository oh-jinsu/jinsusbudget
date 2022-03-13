import 'dart:async';

import 'package:jinsusbudget/__core__/controller.dart';
import 'package:jinsusbudget/models/expenditure.dart';
import 'package:jinsusbudget/repositories/budget.dart';
import 'package:jinsusbudget/repositories/expenditure.dart';
import 'package:jinsusbudget/repositories/piggy_bank.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';
import 'package:rxdart/subjects.dart';

class HomeController extends Controller {
  final RouteService routeService;
  final DialogService dialogService;
  final BudgetRepository budgetRepository;
  final PiggyBankRepository piggyBankRepository;
  final ExpenditureRepository expenditureRepository;

  late final _today = BehaviorSubject<DateTime>(onListen: _initToday);
  Stream<DateTime> get today => _today.stream;

  late final _spare = BehaviorSubject<int>(onListen: _initSpare);
  Stream<int> get spare => _spare.stream;

  late final _budget = BehaviorSubject<int>(onListen: _initBudget);
  Stream<int> get budget => _budget.stream;

  late final _expenditures =
      BehaviorSubject<List<ExpenditureModel>>(onListen: _initExpenditures);
  Stream<List<ExpenditureModel>> get expenditures => _expenditures.stream;

  HomeController({
    required this.routeService,
    required this.dialogService,
    required this.budgetRepository,
    required this.piggyBankRepository,
    required this.expenditureRepository,
  });

  void _initToday() async {
    final result = DateTime.now();

    _today.sink.add(result);
  }

  void _initSpare() async {
    final model = await piggyBankRepository.find();

    if (model == null) {
      return;
    }

    final result = model.amount;

    _spare.sink.add(result);
  }

  void _initBudget() async {
    final model = await budgetRepository.find();

    if (model == null) {
      return;
    }

    final result = model.amount;

    _budget.sink.add(result);
  }

  void _initExpenditures() async {
    final today = DateTime.now();

    final models = await expenditureRepository.findAllForToday(dateTime: today);

    _expenditures.sink.add(models);
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
      await budgetRepository.sub(amount: _budget.value);

      await piggyBankRepository.sub(amount: -1 * leftover);

      _initSpare();
    } else {
      await budgetRepository.sub(amount: amount);
    }

    _initBudget();

    final array = _expenditures.value;

    final result = [...array, model];

    _expenditures.sink.add(result);
  }

  @override
  void onDispose() {
    _today.close();

    _spare.close();

    _budget.close();

    _expenditures.close();
  }
}
