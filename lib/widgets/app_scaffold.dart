import 'package:flutter/material.dart';
import 'package:pros_cons/util.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  AppScaffold({
    Key key,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text("PROS & CONS", style: _titleStyle),
        backgroundColor: purple,
      ),
      body: body,
    );
  }
}
