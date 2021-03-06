import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/components/new_decision_button.dart';

class NoHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "You haven't created any lists yet.",
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.blueGrey[200],
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Previous lists will show up here.",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueGrey[200],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Get started with the button below!",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueGrey[200],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: NewDecisionButton(
              onPressed: () {
                FirebaseAnalytics().logEvent(
                  name: "new_decision",
                  parameters: {
                    'position': "no_history",
                  },
                );
                Navigator.of(context).pushNamed("/Create");
              },
            ),
          ),
        ],
      ),
    );
  }
}
