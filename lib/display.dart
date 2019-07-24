import 'package:flutter/material.dart';

/// TODO fix things
///
/// This would be a good idea if this would Hot Reload.
/// I know there's something that could be used in this way for styles.
/// At points it begins to be a pain in the ass coming up with multiple styles.
///
/// Would be nice to have a way to centralize some of the Styles:
///
///   Display.appBar.title
///   Display.text.resultsHeader
///   Display.text.resultsScore

class Display {
  // Mostly used for the AppBar title style
  static TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
  );

  // Used for the button text
  static TextStyle buttonStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  static TextStyle resultScoreStyle = TextStyle();

  static TextStyle resultScoreHeaderStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w800,
  );
}
