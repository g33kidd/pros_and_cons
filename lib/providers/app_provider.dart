import 'package:flutter_udid/flutter_udid.dart';
import 'package:pros_cons/imports.dart';

class AppProvider extends ChangeNotifier {
  String udid;

  AppProvider() {
    init();
  }

  init() async {
    udid = await FlutterUdid.udid;
    notifyListeners();
  }
}
