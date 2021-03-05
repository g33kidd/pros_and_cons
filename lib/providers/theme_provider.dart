import 'package:pros_cons/imports.dart';
import 'package:pros_cons/providers/preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const modePrefKey = "theme:darkmode";

// TODO this should be SharedPrefs instead of bool for defaultMode?

class ThemeProvider extends ChangeNotifier {
  final PreferencesProvider preferences;
  final bool defaultMode;

  ThemeMode _mode = ThemeMode.light;

  ThemeProvider({this.defaultMode, this.preferences}) {
    if (defaultMode != null) {
      if (defaultMode) {
        _mode = ThemeMode.dark;
      } else {
        _mode = ThemeMode.light;
      }
    } else {
      _mode = ThemeMode.dark;
    }

    preferences.addListener(() {
      // idk if this is needed...
      // preferences.prefs.get(modePrefKey);
      // print("preferences injection worked!");
      // print("we probably changed!");
    });
  }

  ThemeMode get mode {
    return _mode;
  }

  bool get dark {
    return _mode == ThemeMode.dark;
  }

  bool get light {
    return _mode == ThemeMode.light;
  }

  void setDark(bool value) async {
    preferences.assign(modePrefKey, value);
    if (value) _mode = ThemeMode.dark;
    if (!value) _mode = ThemeMode.light;
    notifyListeners();
  }

  void toggle() async {
    if (dark) _mode = ThemeMode.light;
    if (light) _mode = ThemeMode.dark;
    preferences.assign(modePrefKey, dark);
    notifyListeners();
  }
}
