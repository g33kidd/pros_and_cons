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
}
