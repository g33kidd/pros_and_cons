import 'package:flutter/material.dart';

final Color purple = Color(0xFF7665E6);

final Color red = Color(0xFFD05959);
final Color green = Color(0xFF4DBE54);
final Color grey = Color(0xFFE4E4E4);

String describeScore(score) {
  if (score > 0) {
    return "YES";
  } else {
    return "NO";
  }
}

// Shows a snackbar with a specific theme.
void showSnackbar(BuildContext context) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      backgroundColor: purple,
      content: Text(
        "History detailed info is coming soon!",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

final funkyLinesDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/funky-lines.png"),
    repeat: ImageRepeat.repeat,
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
      Colors.white.withOpacity(0.4),
      BlendMode.dstATop,
    ),
  ),
);
