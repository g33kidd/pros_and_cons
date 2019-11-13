import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/mood_icon.dart';
import 'package:provider/provider.dart';

class Message extends StatelessWidget {
  final DocumentSnapshot document;

  Message(this.document);

  // Future<bool> sentByMe() async {
  //   var user =
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);
    final sentBySelf = app.uid == document['user_id'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          sentBySelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 8.0),
        if (!sentBySelf)
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text("Some Username"),
          ),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: sentBySelf ? Colors.blue : Colors.blueGrey[50],
          ),
          child: Text(
            document['text'],
            style: TextStyle(
              color: sentBySelf ? Colors.white : Colors.black,
            ),
          ),
        ),
        if (document['decision'] != null)
          FutureBuilder(
            future: document['decision'].get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.exists) {
                  return DecisionCard(Decision.fromSnapshot(snapshot.data));
                } else {
                  return DecisionCard(Decision(), maybeDeleted: true);
                }
              } else {
                return Offstage();
              }
            },
          )
      ],
    );
  }
}

class DecisionCard extends StatelessWidget {
  final Decision decision;
  final Function onPressed;
  final Color color;
  final bool maybeDeleted;

  DecisionCard(this.decision, {this.onPressed, this.color, this.maybeDeleted});

  @override
  Widget build(BuildContext context) {
    if (maybeDeleted != null && maybeDeleted) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: color ?? Colors.blueGrey[50],
        ),
        child: Center(
          child: Text("Decision was deleted/no longer exists."),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: color ?? Colors.blueGrey[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MoodIcon(mood: decision.mood),
            Text(
              decision.objective,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              decision.totalScore.toString(),
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
