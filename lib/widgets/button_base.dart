import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonBase extends StatelessWidget {
  final Function onPressed;
  final BoxDecoration decoration;
  final Widget child;
  final EdgeInsetsGeometry padding;

  ButtonBase({
    Key key,
    @required this.onPressed,
    @required this.decoration,
    @required this.child,
    this.padding,
  }) : super(key: key);

  _onPressed() {
    HapticFeedback.lightImpact();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8.0,
    );

    return GestureDetector(
      onTap: () => _onPressed(),
      child: Container(
        padding: padding ?? defaultPadding,
        decoration: decoration,
        child: child,
      ),
    );
  }
}
