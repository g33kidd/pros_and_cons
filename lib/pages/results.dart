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

    TextStyle _headerStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
    );

    return ListView(
      children: <Widget>[
        Text(decision.objective, style: _headerStyle),
        SizedBox(height: 24.0),
        
        Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Positives (${decision.pros.length})",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                for (var p in decision.pros) Text(p.title),
                SizedBox(height: 8.0),
              ],
            ),
        SizedBox(height: 24.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Negatives (${decision.cons.length})",
              style: TextStyle(
                color: Colors.red,
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            for (var c in decision.cons) Text(c.title),
            SizedBox(height: 8.0),
          ],
        ),
      ],
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
