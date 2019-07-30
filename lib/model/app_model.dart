import 'dart:collection';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:flutter_udid/flutter_udid.dart';

class AppModel extends ChangeNotifier {
  String udid;
  String uid;

  List<Decision> history = [
    Decision(),
    Decision(),
    Decision(),
    Decision(),
    Decision(),
    Decision(),
  ];

  Decision decision;

  UnmodifiableListView<Option> get options =>
      UnmodifiableListView<Option>(decision.arguments);

  UnmodifiableListView<Option> get proArguments => UnmodifiableListView<Option>(
      decision.arguments.where((d) => d.type == OptionType.PRO));

  AppModel() {
    FlutterUdid.udid.then((_udid) {
      udid = _udid;
      print(_udid);
    });

    // Creates a new default decision
    decision = Decision();
  }

  /// Removes an option from the current decision being edited.
  void deleteOption(Option option) {
    decision.arguments.remove(option);
    notifyListeners();
  }

  void addOption() {
    FirebaseAnalytics().logEvent(name: "add_option");
    decision.arguments.add(Option(
      importance: 5,
      type: OptionType.CON,
    ));
    notifyListeners();
  }

  /// Similar to [deleteOption].
  /// Removes an option from the current decision being edited at specified [index].
  void deleteOptionAt(int index) {
    decision.arguments.removeAt(index);
    notifyListeners();
  }

  void updateOption(int index, Option newOption) {
    decision.arguments[index] = newOption;
    notifyListeners();
  }

  void updateObjective(String value) {
    decision.objective = value;
    notifyListeners();
  }

  void newDecision() {
    decision = Decision();
    notifyListeners();
  }
}
