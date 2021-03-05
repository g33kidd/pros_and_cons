import 'package:pros_cons/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  String path;
  dynamic defaultValue;

  Pref(
    this.path, {
    this.defaultValue,
  });
}

class PreferencesProvider extends ChangeNotifier {
  SharedPreferences prefs;

  PreferencesProvider() {
    init();
  }

  init() async {
    this.prefs = await SharedPreferences.getInstance();

    // what was i doing here..
    // final keys = this.prefs.getKeys();

    notifyListeners();
  }

  T read<T>(String path, T initialValue) {
    if (T is String) return prefs.getString(path) as T;
    if (T is List<String>) return prefs.getStringList(path) as T;
    if (T is double) return prefs.getDouble(path) as T;
    if (T is int) return prefs.getInt(path) as T;
    if (T is bool) return prefs.getBool(path) as T;
    return initialValue;
  }

  assign<T>(String path, T value) {
    if (T is String) prefs.setString(path, value as String);
    if (T is List<String>) prefs.setStringList(path, value as List<String>);
    if (T is double) prefs.setDouble(path, value as double);
    if (T is int) prefs.setInt(path, value as int);
    if (T is bool) prefs.setBool(path, value as bool);

    notifyListeners();
  }

  delete(String path) {
    prefs.remove(path);
    notifyListeners();
  }
}
