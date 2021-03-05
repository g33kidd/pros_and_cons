import 'package:pros_cons/imports.dart';

class Box extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;

  Box({
    Key key,
    this.child,
    this.color,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(6),
      padding: padding ?? EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color ?? Colors.grey[200],
      ),
      child: child,
    );
  }
}
