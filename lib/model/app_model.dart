import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

class AppModel extends ChangeNotifier {
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
    decision = Decision();
    decision.objective = "Test";
    decision.arguments = [
      Option(
          importance: 1,
          title: "1 Just testing some things.",
          type: OptionType.CON),
      Option(
          importance: 2,
          title: "2 Just testing some things.",
          type: OptionType.PRO),
      Option(
          importance: 4,
          title: "3 Just testing some things.",
          type: OptionType.CON),
      Option(
          importance: 1,
          title: "4 Just testing some things.",
          type: OptionType.PRO),
      Option(
          importance: 2,
          title: "5 Just testing some things.",
          type: OptionType.PRO),
      Option(
          importance: 3,
          title: "6 Just testing some things.",
          type: OptionType.CON),
    ];
    // TODO: load history from storage here...
    print("Init appModel");
  }

  /// Removes an option from the current decision being edited.
  void deleteOption(Option option) {
    decision.arguments.remove(option);
    notifyListeners();
  }

  void addOption() {
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
}