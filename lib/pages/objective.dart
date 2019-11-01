import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/widgets/mood_selection.dart';
import 'package:provider/provider.dart';

class ObjectivePage extends StatefulWidget {
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

    return Consumer<DecisionsModel>(builder: (context, decisions, snapshot) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Let's start with an objective.", style: _headerText),
              Text("What are you making a decision on?", style: _subHeaderText),
              SizedBox(height: 24.0),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                maxLength: 300,
                maxLines: 4,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                onChanged: (s) => decisions.updateObjective(s),
              ),
              SizedBox(height: 24.0),
              Text("How are you feeling about it?", style: _headerText),
              Text("This will come in handy later.", style: _subHeaderText),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 23.0),
                child: MoodSelection(
                  onChanged: (m) {
                    decisions.decision.mood = m;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
