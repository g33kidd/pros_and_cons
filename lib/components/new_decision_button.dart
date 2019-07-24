import 'package:flutter/material.dart';
import 'package:pros_cons/display.dart';
import 'package:pros_cons/widgets/button_base.dart';

class NewDecisionButton extends StatelessWidget {
  final Function onPressed;

  NewDecisionButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      onPressed: () => onPressed(),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.pinkAccent,
      ),
      child: Center(
        child: Text(
          "NEW DECISION",
          style: Display.buttonStyle,
        ),
      ),
    );
  }
}
