import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/util.dart';
import 'package:pros_cons/widgets/button_base.dart';
import 'package:pros_cons/widgets/result_card.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../display.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<AppModel>(context).darkMode;
    final decisions = Provider.of<DecisionsModel>(context);
    final decision = decisions.decision;

    decision.buildScore();

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

    return ListView(
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
          color: Colors.blueGrey[50],
          children: <Widget>[
            Text(
              "REVIEW YOUR RESULTS FOR",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              decision.objective,
              style: TextStyle(
                color: Colors.blueGrey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "You are feeling $mood about it.",
              style: TextStyle(
                color: (decision.mood != Mood.MEH)
                    ? (decision.mood == Mood.HAPPY ? green : red)
                    : Colors.orange,
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
            color: darkMode ? Colors.grey : Colors.black,
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
          color: Colors.blueGrey[50],
          children: <Widget>[
            ...decision.getPros
                .map(
                  (f) => Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          describeEnum(f.type),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                            color: (f.type == OptionType.CON ? red : green),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: Text(
                            f.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Text(
                          "+${f.importance.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            ...decision.getCons
                .map(
                  (f) => Padding(
                    padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          describeEnum(f.type),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                            color: (f.type == OptionType.CON ? red : green),
                          ),
                        ),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: Text(
                            f.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Text(
                          "-${f.importance.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
        SizedBox(height: 24.0),
        Text(
          "Final Decision Score".toUpperCase(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: darkMode ? Colors.grey : Colors.black,
          ),
        ),
        SizedBox(height: 12.0),
        ResultsCard(
          row: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          color: Colors.blueGrey[50],
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
                  style: TextStyle(fontSize: 32.0),
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
                  style: TextStyle(fontSize: 32.0),
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
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  decision.totalScore.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w900,
                    color: (decision.totalScore < 0) ? red : green,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 22.0),
        ButtonBase(
          onPressed: () async {
            FirebaseAnalytics().logEvent(name: "social_share");
            await Share.share(
              "I just weighed my pros and cons for a decision on this app. Checkout PROS & CONS on the Play Store! http://bit.ly/32sRgb9",
              subject: "PROS & CONS",
            );
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: purple,
                duration: Duration(seconds: 3),
                content: Text(
                  "Thanks for sharing! ❤️ 🙌",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.pinkAccent,
          ),
          child: Center(
            child: Text(
              "Helpful? Share app with Friends",
              style: Display.buttonStyle.copyWith(fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
