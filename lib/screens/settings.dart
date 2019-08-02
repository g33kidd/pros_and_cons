import 'package:flutter/material.dart';
import 'package:pros_cons/display.dart';

/// TODO implement the settings screen and setup the SharedPreferences package.
/// settings could also be saved to some user profile on Firebase maybe...

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROS & CONS", style: Display.titleStyle),
      ),
      body: Container(),
    );
  }
}
