import 'package:flutter/widgets.dart';
import 'package:jinsusbudget/__core__/context.dart';

abstract class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    contextQueue.addLast(context);

    onWillMount();

    Future.delayed(Duration.zero, onMount);

    return WillPopScope(
      onWillPop: () async {
        onUnmount();

        contextQueue.remove(context);

        return true;
      },
      child: render(context),
    );
  }

  void onWillMount() {}

  void onMount() {}

  void onUnmount() {}

  Widget render(BuildContext context);
}
