import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

TextStyle _headerStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

class ResultsPage extends StatelessWidget {
  final Decision decision;

  ResultsPage({Key key, this.decision}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final score = decision.buildScore();
    final proScore = score["pro"];
    final conScore = score["con"];
    final modScore = proScore - conScore;

    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 18.0,
              ),
              child: Text(decision.objective, style: _headerStyle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("PROS SCORE", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8.0),
                    Text(
                      "${proScore.toInt()}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      modScore.toInt().toString(),
                      style: TextStyle(
                        fontSize: 45.0,
                        color: (modScore > 0) ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text("CONS SCORE", style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 8.0),
                    Text(
                      "${conScore.toInt()}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "PROS (${decision.pros.length})",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 22.0,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    for (var p in decision.pros)
                      Text(
                        p.title,
                        style: TextStyle(color: Colors.white),
                      ),
                    SizedBox(height: 8.0),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "CONS (${decision.cons.length})",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22.0,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    for (var c in decision.cons)
                      Text(
                        c.title,
                        style: TextStyle(color: Colors.white),
                      ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
