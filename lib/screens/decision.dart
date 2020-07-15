import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/screens/edit_decision.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';
import 'package:pros_cons/widgets/result_card.dart';
import 'package:pros_cons/widgets/share_button.dart';
import 'package:provider/provider.dart';

import '../util.dart';

class DecisionResultsScreen extends StatelessWidget {
  final Decision decision;
  final DocumentSnapshot snapshot;

  DecisionResultsScreen({
    Key key,
    this.decision,
    this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<AppModel>(context).darkMode;
    final decisions = Provider.of<DecisionsModel>(context);
    final total = decision.totalScore;
    final threshold =
        (decision.proScore + decision.conScore) / decision.arguments.length;

    // TODO this was just a quick workup, improve and move this elsewhere.
    String result = "";
    if (decision.totalScore < -threshold) {
      result = "Probably Shouldn't";
    } else if (total >= -threshold && total < 0) {
      result = "I'd say no.";
    } else if (total == 0) {
      result = "Maybe.";
    } else if (total <= threshold && total > 0) {
      result = "Go for it!";
    } else if (total > threshold) {
      result = "Absolutely!";
    } else {
      result = "I really don't know!";
    }

    final mood = describeEnum(decision.mood);

    return AppScaffold(
      title: "RESULTS",
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(
            Icons.mode_edit,
            size: 16.0,
            color: Colors.white,
          ),
          label: Text(
            "EDIT",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            // print(decisions.decision.toMap());
            print(decision.toMap());
            // decisions.decision = decision;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EditDecisionScreen(
                  decision: decision,
                  snapshot: snapshot,
                ),
              ),
            );
          },
        ),
      ],
      body: ListView(
        padding: EdgeInsets.all(18.0),
        children: <Widget>[
          Center(
            child: FittedBox(
              child: Text(
                result.toUpperCase(),
                style: TextStyle(
                  color: total > 0 ? green : red,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SizedBox(height: 18.0),
          ResultsCard(
            column: true,
            color: !darkMode ? Colors.blueGrey[50] : Color(0xFF191919),
            children: <Widget>[
              Text(
                DateFormat().format(decision.created),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: darkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                decision.objective,
                style: TextStyle(
                  color: Colors.blueGrey[500],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "You are feeling $mood about it.",
                style: TextStyle(
                  color: decision.moodTextColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.0),
          Text(
            "Argument Breakdown".toUpperCase(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.0),
          ResultsCard(
            column: true,
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
              bottom: 8.0,
            ),
            color: !darkMode ? Colors.blueGrey[50] : Color(0xFF191919),
            children: <Widget>[
              ...decision.getPros
                  .map((it) => ArgumentListItem(option: it))
                  .toList(),
              ...decision.getCons
                  .map((it) => ArgumentListItem(option: it))
                  .toList(),
            ],
          ),
          SizedBox(height: 24.0),
          Text(
            "Final Decision Score".toUpperCase(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 12.0),
          ResultsCard(
            row: true,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            color: !darkMode ? Colors.blueGrey[50] : Color(0xFF191919),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "PROS",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: green,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    decision.proScore.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 32.0,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "CONS",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: red,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    decision.conScore.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 32.0,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Column(
                children: <Widget>[
                  Text(
                    "TOTAL",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    decision.totalScore.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: decision.scoreTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 22.0),
          ShareButton(),
        ],
      ),
    );
  }
}

class ArgumentListItem extends StatelessWidget {
  final Option option;

  ArgumentListItem({this.option});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<AppModel>(context).darkMode;
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            describeEnum(option.type),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
              color: (option.type == OptionType.CON ? red : green),
            ),
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Text(
              option.title ?? "Title Not Available",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Text(
            "+${option.importance.toStringAsFixed(0)}",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
              color: darkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
