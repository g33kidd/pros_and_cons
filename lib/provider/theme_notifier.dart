import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  List<ThemeData> themes = [];
  ThemeData currentTheme;
}
