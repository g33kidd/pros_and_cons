import 'package:flutter/material.dart';
import 'package:pros_cons/util.dart';

class AdFreeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(
      color: Colors.white,
      // fontSize: 22.0,
      fontWeight: FontWeight.w800,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text("REMOVE ADS", style: _titleStyle),
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
