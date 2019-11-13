import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';

class AppNotifier extends ChangeNotifier {
  bool darkMode;

  String deviceId;
  String userId;

  AppNotifier() {
    init();
  }

  init() async {
    try {
      deviceId = await FlutterUdid.consistentUdid;
      notifyListeners();
    } catch (e) {
      print("Error fetching the Unique Device ID: $e");
    }
  }
}
