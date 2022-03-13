import 'package:flutter/widgets.dart';
import 'package:jinsusbudget/__core__/context.dart';
import 'package:jinsusbudget/debug.dart';

class _View extends StatefulWidget {
  final String label;
  final Widget Function(BuildContext) renderer;
  final void Function() onMount;
  final void Function() onWillMount;
  final void Function() onUnmount;

  const _View({
    Key? key,
    required this.label,
    required this.renderer,
    required this.onMount,
    required this.onWillMount,
    required this.onUnmount,
  }) : super(key: key);

  @override
  State<_View> createState() => __ViewState();
}

class __ViewState extends State<_View> {
  @override
  void initState() {
    widget.onWillMount();

    super.initState();
  }

  @override
  void dispose() {
    widget.onUnmount();

    contextQueue.remove(context);

    Debug.log(
      "${widget.label} will be unmounted, stack size is ${contextQueue.length}",
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!contextQueue.contains(context)) {
      contextQueue.add(context);

      Debug.log(
        "${widget.label} will be mounted, stack size is ${contextQueue.length}",
      );
    }

    Future.delayed(Duration.zero, widget.onMount);

    return widget.renderer(context);
  }
}

abstract class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _View(
      label: toString(),
      renderer: render,
      onMount: onMount,
      onWillMount: onCreate,
      onUnmount: onDestroy,
    );
  }

  void onCreate() {}

  void onMount() {}

  void onDestroy() {}

  Widget render(BuildContext context);
}
