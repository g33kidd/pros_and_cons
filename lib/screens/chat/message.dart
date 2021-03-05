import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/mood_icon.dart';

// class Message extends StatelessWidget {
//   final DocumentSnapshot document;

//   Message(this.document);

//   @override
//   Widget build(BuildContext context) {
//     final app = Provider.of<AppModel>(context);
//     final sentBySelf = app.uid == document['user_id'];

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment:
//           sentBySelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(height: 8.0),
//         if (!sentBySelf)
//           Padding(
//             padding: EdgeInsets.all(6.0),
//             child: Text("Some Username"),
//           ),
//         Container(
//           padding: EdgeInsets.all(12.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6.0),
//             color: sentBySelf ? Colors.blue : Colors.blueGrey[50],
//           ),
//           child: Text(
//             document['text'],
//             style: TextStyle(
//               color: sentBySelf ? Colors.white : Colors.black,
//             ),
//           ),
//         ),
//         if (document['decision'] != null)
//           FutureBuilder(
//             future: document['decision'].get(),
//             builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.data.exists) {
//                   return DecisionCard(Decision.fromSnapshot(snapshot.data));
//                 } else {
//                   return DecisionCard(Decision(), maybeDeleted: true);
//                 }
//               } else {
//                 return Offstage();
//               }
//             },
//           )
//       ],
//     );
//   }
// }

class DecisionCard extends StatelessWidget {
  final Decision decision;
  final Function onPressed;
  final Color color;
  final bool maybeDeleted;

  DecisionCard(this.decision, {this.onPressed, this.color, this.maybeDeleted});

  @override
  Widget build(BuildContext context) {
    if (maybeDeleted != null && maybeDeleted) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: color ?? Colors.blueGrey[50],
        ),
        child: Center(
          child: Text("Decision was deleted/no longer exists."),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: color ?? Colors.blueGrey[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MoodIcon(mood: decision.mood),
            Text(
              decision.objective,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              decision.score.total.toString(),
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewMessage extends HookWidget {
  final DocumentSnapshot document;

  NewMessage(this.document);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(userProvider);
    final self = user.uid == document['user_id'];

    final selfMargin = EdgeInsets.only(left: 36);

    return Container(
      margin: self ? selfMargin : EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            // TODO except this "SOME USER" needs to come from somewhere else.
            self ? "YOU" : "SOME USER",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: self ? pink : darkPurple,
            ),
          ),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(document['text']),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
