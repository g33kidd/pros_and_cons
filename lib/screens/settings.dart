import 'package:flutter/material.dart';

import '../util.dart';

/// TODO implement the settings screen and setup the SharedPreferences package.
/// settings could also be saved to some user profile on Firebase maybe...

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text("PROS & CONS", style: _titleStyle),
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
