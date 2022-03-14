import 'package:flutter/widgets.dart';
import 'package:jinsusbudget/__core__/context.dart';
import 'package:jinsusbudget/debug.dart';

class _View extends StatefulWidget {
  final BuildContext inheritedContext;
  final String label;
  final Widget Function(BuildContext) renderer;
  final void Function(BuildContext) onCreate;
  final void Function(BuildContext) onStart;
  final void Function(BuildContext) onDestroy;

  const _View({
    Key? key,
    required this.inheritedContext,
    required this.label,
    required this.renderer,
    required this.onCreate,
    required this.onStart,
    required this.onDestroy,
  }) : super(key: key);

  @override
  State<_View> createState() => __ViewState();
}

class __ViewState extends State<_View> {
  @override
  void initState() {
    widget.onCreate(widget.inheritedContext);

    super.initState();
  }

  @override
  void dispose() {
    widget.onDestroy(context);

    contextQueue.remove(context);

    Debug.log(
      "${widget.label} is being destroyed, stack size is ${contextQueue.length}",
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!contextQueue.contains(context)) {
      contextQueue.add(context);

      Debug.log(
        "${widget.label} is being mounted, stack size is ${contextQueue.length}",
      );

      Future.delayed(Duration.zero, () => widget.onStart(context));
    }

    return widget.renderer(context);
  }
}

abstract class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _View(
      inheritedContext: context,
      label: toString(),
      renderer: render,
      onCreate: onCreate,
      onStart: onStart,
      onDestroy: onDestroy,
    );
  }

  void onCreate(BuildContext context) {}

  void onStart(BuildContext context) {}

  void onDestroy(BuildContext context) {}

  Widget render(BuildContext context);
}
