import 'package:jinsusbudget/services/system.dart';
import 'package:jinsusbudget/services/dialog.dart';
import 'package:jinsusbudget/services/route.dart';

class AppDependencies {
  final bool isProduction;

  AppDependencies({required this.isProduction});

  final _Services service = _Services();
}

class _Services {
  final RouteService route = RouteService();

  final DialogService dialog = DialogService();

  final SystemService system = SystemService();
}
