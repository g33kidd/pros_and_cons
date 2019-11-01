import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:flutter_udid/flutter_udid.dart';

class AppModel extends ChangeNotifier {
  String udid;
  String uid;

  List<Decision> history = <Decision>[];

  AppModel() {
    init();
  }

  init() async {
    final uniqueDeviceID = await FlutterUdid.udid;
    print("Got UDID: $uniqueDeviceID");
    udid = uniqueDeviceID;
    notifyListeners();
  }
}
