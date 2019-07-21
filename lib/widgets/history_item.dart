import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/util.dart';
import 'package:pros_cons/widgets/mood_icon.dart';

class HistoryItem extends StatelessWidget {
  final Decision decision;
  final Function onDelete;

  HistoryItem({
    Key key,
    this.decision,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = describeScore(decision.totalScore);
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: purple,
            content: Text(
              "History detailed info is coming soon!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
      onLongPress: () async {
        HapticFeedback.mediumImpact();
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text("Sure you want to delete?"),
              elevation: 1.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.check),
                  label: Text(
                    "YES!",
                    style: TextStyle(
                      color: purple,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () async => await onDelete(),
                ),
                FlatButton(
                  child: Text(
                    "NO",
                    style: TextStyle(
                      color: red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
        margin: EdgeInsets.only(
          bottom: 8.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "$description (${decision.totalScore.toStringAsFixed(0)})",
              style: TextStyle(
                fontSize: 22.0,
                color: (decision.totalScore > 0) ? Colors.green : Colors.red,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              decision.objective,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey[500],
              ),
            ),
            MoodIcon(mood: decision.mood),
          ],
        ),
      ),
    );
  }
}
