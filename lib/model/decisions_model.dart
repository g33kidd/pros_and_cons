import 'dart:collection';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

class DecisionsModel extends ChangeNotifier {
  Decision _decision;

  Decision get decision => _decision;

  set decision(Decision value) {
    _decision = value;
    notifyListeners();
  }

  UnmodifiableListView<Option> get options =>
      UnmodifiableListView<Option>(decision.arguments);

  UnmodifiableListView<Option> get proArgs => UnmodifiableListView<Option>(
      decision.arguments.where((it) => it.type == OptionType.PRO));

  UnmodifiableListView<Option> get conArgs => UnmodifiableListView<Option>(
      decision.arguments.where((it) => it.type == OptionType.CON));

  DecisionsModel() {
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

  void clearOptions() {
    decision.arguments.clear();
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
