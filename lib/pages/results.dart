import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

class ResultsPage extends StatefulWidget {
  final Decision decision;

  ResultsPage({Key key, this.decision}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final score = widget.decision.buildScore();
    final proScore = score["pro"];
    final conScore = score["con"];
    final modScore = proScore - conScore;

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
          Text(widget.decision.objective, style: _headerStyle),
          SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widget.decision.pros.length} Positives",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              for (var p in widget.decision.pros)
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
                "${widget.decision.cons.length} Negatives",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              for (var c in widget.decision.cons)
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
          SizedBox(height: 24.0),
          RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text("FINISH", style: _infoStyle),
            color: Color(0xFF7665E6),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/Home");
            },
          ),
        ],
      ),
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: <Widget>[
    //     Center(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(
    //           horizontal: 32.0,
    //           vertical: 18.0,
    //         ),
    //         child: Text(decision.objective, style: _headerStyle),
    //       ),
    //     ),
    //     Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Column(
    //           children: <Widget>[
    //             Text("PROS SCORE", style: TextStyle(color: Colors.grey)),
    //             SizedBox(height: 8.0),
    //             Text(
    //               "${proScore.toInt()}",
    //               style: TextStyle(
    //                 fontSize: 20.0,
    //               ),
    //             ),
    //           ],
    //         ),
    //         Expanded(
    //           child: Center(
    //             child: Text(
    //               modScore.toInt().toString(),
    //               style: TextStyle(
    //                 fontSize: 45.0,
    //                 color: (modScore > 0) ? Colors.green : Colors.red,
    //               ),
    //             ),
    //           ),
    //         ),
    //         Column(
    //           children: <Widget>[
    //             Text("CONS SCORE"),
    //             SizedBox(height: 8.0),
    //             Text(
    //               "${conScore.toInt()}",
    //               style: TextStyle(
    //                 fontSize: 20.0,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //     Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               "PROS (${decision.pros.length})",
    //               style: TextStyle(
    //                 color: Colors.green,
    //                 fontSize: 22.0,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 18.0,
    //             ),
    //             for (var p in decision.pros) Text(p.title),
    //             SizedBox(height: 8.0),
    //           ],
    //         ),
    //         Expanded(child: Container()),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               "CONS (${decision.cons.length})",
    //               style: TextStyle(
    //                 color: Colors.red,
    //                 fontSize: 22.0,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 18.0,
    //             ),
    //             for (var c in decision.cons) Text(c.title),
    //             SizedBox(height: 8.0),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
