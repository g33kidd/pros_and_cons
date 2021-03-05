import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This can be deleted I think?
///

// class AppModel extends ChangeNotifier {
//   bool darkMode = false;
//   bool displayChangelog = true;
//   bool showSupportDialog = true;

//   String lastVersion;

//   String udid;
//   String uid;

//   List<Decision> history = <Decision>[];

//   AppModel() {
//     init();
//   }

//   switchTheme() async {
//     if (!darkMode) {
//       darkMode = true;
//     } else {
//       darkMode = false;
//     }

//     /// this doesn't matter?
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool("dark_mode", darkMode);

//     notifyListeners();
//   }

//   init() async {
//     udid = await FlutterUdid.udid;

//     final prefs = await SharedPreferences.getInstance();
//     darkMode = prefs.getBool("dark_mode") ?? false;
//     displayChangelog = prefs.getBool("display_changelog") ?? false;
//     // lastVersion = prefs.getString("last_version") ?? ;

//     notifyListeners();
//   }
// }
