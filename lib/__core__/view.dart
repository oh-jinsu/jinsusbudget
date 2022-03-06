import 'package:flutter/widgets.dart';
import 'package:jinsusbudget/__core__/context.dart';

abstract class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    contextQueue.addLast(context);

    return WillPopScope(
      onWillPop: () async {
        contextQueue.remove(context);

        return true;
      },
      child: render(context),
    );
  }

  Widget render(BuildContext context);
}
