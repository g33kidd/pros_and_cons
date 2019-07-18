import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);
    final decision = app.decision;

    final score = decision.buildScore();
    final proScore = score["pro"];
    final conScore = score["con"];
    final modScore = score["total"];

    TextStyle _headerStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
    );

    TextStyle _listTextStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: Colors.grey[600],
      height: 1.2,
    );

    TextStyle _infoStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    );

    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        right: 24.0,
        left: 24.0,
      ),
      child: ListView(
        children: <Widget>[
          Text(decision.objective, style: _headerStyle),
          SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "${decision.getPros.length} Positives",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              for (var p in decision.getPros)
                Text("${p.title} (${p.importance.toInt()})",
                    style: _listTextStyle),
              SizedBox(height: 8.0),
            ],
          ),
          SizedBox(height: 18.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "${decision.getCons.length} Negatives",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              for (var c in decision.getCons)
                Text(
                  "${c.title} (${c.importance.toInt()})",
                  style: _listTextStyle,
                ),
              SizedBox(height: 8.0),
            ],
          ),
          SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("PRO SCORE",
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300)),
              Text(
                "${proScore.toInt().toString()}",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.green[300],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("CON SCORE",
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300)),
              Text(
                "${conScore.toInt().toString()}",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.red[300],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("DECISION SCORE",
                  style:
                      TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600)),
              Text(
                "${modScore.toInt().toString()}",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  color: (modScore > 0) ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
