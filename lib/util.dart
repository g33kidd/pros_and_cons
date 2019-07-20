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
