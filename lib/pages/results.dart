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
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(decision.objective, style: _headerStyle),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pros (${decision.pros.length})",
                    style: TextStyle(color: Colors.white),
                  ),
                  for (var p in decision.pros)
                    Text(
                      p.title,
                      style: TextStyle(color: Colors.white),
                    ),
                ],
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Cons (${decision.cons.length})",
                    style: TextStyle(color: Colors.white),
                  ),
                  for (var c in decision.cons)
                    Text(
                      c.title,
                      style: TextStyle(color: Colors.white),
                    ),
                ],
              ),
            ],
          ),
          Text("Mood: ${decision.mood}"),
          Text("Pro score: $proScore"),
          Text("Con score: $conScore"),
          Text("Mod score: $modScore"),
          for (var d in decision.pros) Text(d.title),
          for (var d in decision.cons) Text(d.title),
        ],
      ),
    );
  }
}
