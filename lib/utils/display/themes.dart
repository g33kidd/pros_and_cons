import 'package:pros_cons/imports.dart';

final defaultTheme = ThemeData(
  accentColor: purple,
  canvasColor: Colors.white,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: purple,
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
  ),
  appBarTheme: AppBarTheme(
    color: purple,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 20.0,
      ),
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: purple),
  sliderTheme: SliderThemeData(
    activeTrackColor: purple,
    inactiveTrackColor: Colors.black12,
    trackHeight: 6.0,
    valueIndicatorColor: purple,
    thumbColor: purple,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
    overlayColor: purple.withAlpha(52),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
    activeTickMarkColor: Colors.white.withAlpha(25),
    inactiveTickMarkColor: Colors.black.withAlpha(14),
    tickMarkShape: RoundSliderTickMarkShape(
      tickMarkRadius: 3.0,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.all(16.0),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
        color: Colors.black12,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: purple, width: 2.5),
    ),
  ),
);

final defaultDarkTheme = ThemeData(
  accentColor: purple,
  canvasColor: Color(0xFF333333),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: purple,
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
  ),
  appBarTheme: AppBarTheme(
    color: purple,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 20.0,
      ),
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: purple),
  dividerTheme: DividerThemeData(
    color: Color(0xFF333333),
    thickness: 1.0,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: purple,
    inactiveTrackColor: Colors.black12,
    trackHeight: 6.0,
    valueIndicatorColor: purple,
    thumbColor: purple,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
    overlayColor: purple.withAlpha(52),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
    activeTickMarkColor: Colors.white.withAlpha(25),
    inactiveTickMarkColor: Colors.black.withAlpha(14),
    tickMarkShape: RoundSliderTickMarkShape(
      tickMarkRadius: 3.0,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF191919),
    contentPadding: EdgeInsets.all(16.0),
    helperStyle: TextStyle(
      color: Colors.white,
    ),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    counterStyle: TextStyle(
      color: Colors.grey[200],
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
        color: Colors.black12,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(color: purple, width: 2.5),
    ),
  ),
);
