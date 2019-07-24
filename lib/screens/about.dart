import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROS & CONS"),
      ),
      body: SafeArea(
        child: Text("Hello this is information!"),
      ),
    );
  }
}
