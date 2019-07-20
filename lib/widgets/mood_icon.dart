import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/util.dart';

class MoodIcon extends StatelessWidget {
  final Mood mood;
  final double size;

  MoodIcon({
    Key key,
    this.mood,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (mood) {
      case Mood.HAPPY:
        color = green;
        icon = Icons.sentiment_very_satisfied;
        break;
      case Mood.MEH:
        color = Colors.orangeAccent;
        icon = Icons.sentiment_neutral;
        break;
      case Mood.SAD:
        color = red;
        icon = Icons.sentiment_very_dissatisfied;
        break;
    }

    return Icon(icon, color: color, size: size);
  }
}
