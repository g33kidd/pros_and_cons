import 'package:flutter/material.dart';

class NewDecisionButton extends StatelessWidget {
  final Function onPressed;

  NewDecisionButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.pinkAccent,
          // Not sure if I want a shadow on the button,
          // there isn't many shadows in this design.
          //
          // boxShadow: [
          // BoxShadow(
          // color: Colors.black.withAlpha(32),
          // offset: Offset(0, 2),
          // blurRadius: 3.0,
          // ),
          // ],
        ),
        child: Center(
          child: Text(
            "NEW DECISION",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
