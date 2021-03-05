import 'package:flutter/material.dart';
import 'package:pros_cons/display.dart';

/// [AppScaffold] is a generalized scaffold for this app. Helpful for
/// reducing future boilerplate and assuming things are mostly reusable.
class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final bool centerTitle;
  final bool needsSafeArea;
  final Widget drawer;
  final List<Widget> actions;
  final Widget bottomNavigationBar;

  AppScaffold({
    Key key,
    this.body,
    this.title,
    this.centerTitle,
    this.actions,
    this.drawer,
    this.needsSafeArea,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget builtBody = body;

    if (needsSafeArea != null && needsSafeArea) {
      builtBody = SafeArea(
        child: builtBody,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: Display.titleStyle),
        centerTitle: centerTitle ?? false,
        actions: actions,
      ),
      drawer: drawer ?? null,
      body: builtBody,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
