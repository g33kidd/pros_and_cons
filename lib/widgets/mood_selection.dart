import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

class MoodSelection extends StatefulWidget {
  final Function onChanged;

  MoodSelection({Key key, this.onChanged}) : super(key: key);

  @override
  _MoodSelectionState createState() => _MoodSelectionState();
}

class _MoodSelectionState extends State<MoodSelection> {
  Mood selectedMood;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: 80.0,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.sentiment_very_satisfied,
              color: (selectedMood == Mood.HAPPY ? Colors.green : Colors.grey),
            ),
            onPressed: () => switchSentiment(Mood.HAPPY),
          ),
          IconButton(
            iconSize: 80.0,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.sentiment_neutral,
              color: (selectedMood == Mood.MEH ? Colors.orange : Colors.grey),
            ),
            onPressed: () => switchSentiment(Mood.MEH),
          ),
          IconButton(
            iconSize: 80.0,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.sentiment_very_dissatisfied,
              color: (selectedMood == Mood.SAD ? Colors.red : Colors.grey),
            ),
            onPressed: () => switchSentiment(Mood.SAD),
          )
        ],
      ),
    );
  }

  void switchSentiment(Mood mood) {
    setState(() {
      selectedMood = mood;
    });

    widget.onChanged(mood);
  }
}
