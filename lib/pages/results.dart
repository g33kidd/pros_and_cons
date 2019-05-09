import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

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
      body: Column(
        children: <Widget>[
          Text("Obj: ${decision.objective}"),
          Text("PROS: ${decision.pros.length}"),
          Text("CONS: ${decision.cons.length}"),
          Text("Mood: ${decision.mood}"),
          Text("Pro score: $proScore"),
          Text("Con score: $conScore"),
          Text("Mod score: $modScore"),
          for (var d in decision.pros) Text("${d.title}"),
          for (var d in decision.cons) Text("${d.title}"),
          // Text("${decision.buildScore().}")
        ],
      ),
    );
  }
}
