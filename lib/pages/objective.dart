import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

class ObjectivePage extends StatefulWidget {
  Decision decision;
  PageController pageController;

  ObjectivePage({Key key, this.decision, this.pageController})
      : super(key: key);

  @override
  _ObjectivePageState createState() => _ObjectivePageState();
}

class _ObjectivePageState extends State<ObjectivePage> {
  @override
  Widget build(BuildContext context) {
    TextStyle _headerText = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
    );

    TextStyle _subHeaderText = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Let's start with an objective.", style: _headerText),
            Text("What are you making a decision on?", style: _subHeaderText),
            SizedBox(height: 32.0),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              maxLength: 45,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: TextStyle(
                fontSize: 18.0,
              ),
              onChanged: (s) {
                setState(() {
                  widget.decision.objective = s;
                });
              },
              autofocus: true,
            ),
            SizedBox(height: 32.0),
            Text("How are you feeling about it?", style: _headerText),
            Text("This will come in handy later.", style: _subHeaderText),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 23.0),
              child: MoodSelection(
                onChanged: (m) {
                  setState(() {
                    widget.decision.mood = m;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                color: Color(0xFF7665E6),
                onPressed: () {
                  widget.pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
              Icons.sentiment_satisfied,
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
              Icons.sentiment_dissatisfied,
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
