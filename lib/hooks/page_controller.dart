import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

PageController usePageController({
  @required int initialPage,
  bool keepPage,
  double viewpointFraction,
}) {
  return use(
    _PageControllerHook(
      initialPage: initialPage,
      keepPage: keepPage,
      viewportFraction: viewpointFraction,
    ),
  );
}

class _PageControllerHook extends Hook<PageController> {
  const _PageControllerHook({
    @required this.initialPage,
    this.keepPage = false,
    this.viewportFraction = 0,
  });

  final int initialPage;
  final bool keepPage;
  final double viewportFraction;

  @override
  HookState<PageController, Hook<PageController>> createState() =>
      _PageControllerHookState();
}

class _PageControllerHookState
    extends HookState<PageController, _PageControllerHook> {
  PageController controller;

  @override
  void initHook() {
    controller = PageController(
      initialPage: hook.initialPage,
      keepPage: false,
      viewportFraction: 1,
    );
  }

  @override
  PageController build(BuildContext context) => controller;

  @override
  void dispose() => controller?.dispose();
}
