import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/screens/decision.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class EditDecisionScreen extends StatefulWidget {
  final Decision decision;
  final DocumentSnapshot snapshot;

  EditDecisionScreen({
    Key key,
    @required this.decision,
    this.snapshot,
  }) : super(key: key);

  @override
  _EditDecisionScreenState createState() => _EditDecisionScreenState();
}

class _EditDecisionScreenState extends State<EditDecisionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final decisions = Provider.of<DecisionsModel>(context);
    final app = Provider.of<AppModel>(context);

    return AppScaffold(
      title: "Editing Decision",
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(
            Icons.check,
            size: 16.0,
            color: Colors.white,
          ),
          label: Text(
            "FINISH EDITING",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            // TODO extract this an make it simpler.
            /// Currently only redirecting in this case so the score will be
            /// updated whenever the user clicks finish.
            print(decisions.decision.toMap());
            final user = await FirebaseAuth.instance.currentUser();
            await widget.snapshot.reference.updateData({
              'objective': decisions.decision.objective,
              'mood': describeEnum(decisions.decision.mood),
              'udid': app.udid,
              'user_id': user.uid,
              'score': decisions.decision.buildScore(),
              'created': decisions.decision.created.toUtc(),
              'arguments': decisions.decision.argumentsList,
            });
            await Future.delayed(Duration.zero);
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => DecisionResultsScreen(
                  decision: decisions.decision,
                  snapshot: widget.snapshot,
                ),
              ),
            );
          },
        ),
      ],
      body: OptionListPage(
        decision: widget.decision,
      ),
    );
  }
}
