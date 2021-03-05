import 'package:pros_cons/imports.dart';

class PageScaffold extends HookWidget {
  final Widget child;
  final Color color;

  PageScaffold({
    Key key,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: color ?? Colors.white,
        child: child,
      ),
    );
  }
}
