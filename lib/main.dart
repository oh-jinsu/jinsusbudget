import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jinsusbudget/bootstrapper.dart';
import 'package:jinsusbudget/dependencies.dart';
import 'package:jinsusbudget/manifest.dart';
import 'package:jinsusbudget/theme/theme.dart';
import 'package:jinsusbudget/views/splash.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies(isProduction: kReleaseMode);

    final bootstrapper = Bootstrapper(dependencies: dependencies);

    bootstrapper.run();

    return MaterialApp(
      title: "진수의 가계부",
      theme: theme,
      home: const SplashView(),
      routes: AppManifest(dependencies).list,
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      debugShowCheckedModeBanner: kDebugMode,
    );
  }
}
