import 'dart:async';

import 'package:jinsusbudget/__core__/controller.dart';
import 'package:jinsusbudget/models/expenditure.dart';
import 'package:jinsusbudget/repositories/budget.dart';
import 'package:jinsusbudget/repositories/expenditure.dart';
import 'package:jinsusbudget/repositories/piggy_bank.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';

class HomeController extends Controller {
  final RouteService routeService;
  final DialogService dialogService;
  final BudgetRepository budgetRepository;
  final PiggyBankRepository piggyBankRepository;
  final ExpenditureRepository expenditureRepository;

  late final _today =
      StreamController<DateTime>.broadcast(onListen: _initToday);
  Stream<DateTime> get today => _today.stream;

  late final _spare = StreamController<int>.broadcast(onListen: _initSpare);
  Stream<int> get spare => _spare.stream;

  late final _budget = StreamController<int>.broadcast(onListen: _initBudget);
  Stream<int> get budget => _budget.stream;

  late final _expenditures = StreamController<List<ExpenditureModel>>.broadcast(
      onListen: _initExpenditures);
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

  @override
  void onDispose() {
    _today.close();

    _spare.close();

    _budget.close();

    _expenditures.close();
  }
}
