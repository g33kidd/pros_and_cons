import 'package:flutter/material.dart';

class TipOfTheDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6.0),
      ),
      margin: EdgeInsets.all(8.0),
    );
  }
}
