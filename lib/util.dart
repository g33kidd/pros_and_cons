import 'package:flutter/material.dart';

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
