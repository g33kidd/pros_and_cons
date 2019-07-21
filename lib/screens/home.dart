import 'package:ads/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/app_drawer.dart';
import 'package:pros_cons/widgets/mood_icon.dart';
import 'package:pros_cons/widgets/no_history.dart';
import 'package:pros_cons/widgets/totd.dart';
import 'package:provider/provider.dart';
import 'package:pros_cons/util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Ads _ads;
  final bool testing = false;

  @override
  void initState() {
    super.initState();

    // Why isn't this working???
    _ads = Ads(
      "ca-app-pub-4846566520266716~9709175425",
      testing: testing,
      bannerUnitId: "ca-app-pub-4846566520266716/6725176015",
    );

    FirebaseAuth.instance.signInAnonymously().then((data) {
      print(data.providerId);
      print("Logged in anonymously!");
      _ads.showBannerAd(testing: testing);
      Future.delayed(Duration(seconds: 10), () => _ads.hideBannerAd());
    });
  }

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);

    final _titleStyle = TextStyle(
      color: Colors.white,
      // fontSize: 22.0,
      fontWeight: FontWeight.w800,
    );

    final _snackKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _snackKey,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: purple,
        title: Text("PROS & CONS", style: _titleStyle),
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // TipOfTheDay(),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('decisions')
                  .where('udid', isEqualTo: app.udid)
                  .orderBy('created', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return Text("Whoops... Something went wrong!");

                if (snapshot.hasData) {
                  if (snapshot.data.documents.length == 0) {
                    return NoHistory();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.0,
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: NewDecisionButton(
                            onPressed: () {
                              FirebaseAnalytics().logEvent(
                                name: "new_decision",
                                parameters: {
                                  'position': "history_list",
                                },
                              );

                              Navigator.pushNamed(context, "/Create");
                            },
                          ),
                        ),
                        ListView(
                          padding: EdgeInsets.all(12.0),
                          shrinkWrap: true,
                          children: <Widget>[
                            ...snapshot.data.documents.map(
                              (DocumentSnapshot doc) {
                                final decision = Decision.fromMap(doc.data);
                                if (doc['udid'] == app.udid)
                                  return HistoryItem(
                                    decision: decision,
                                    onDelete: () async {
                                      await doc.reference.delete();
                                      Navigator.pop(context, true);
                                      _snackKey.currentState.showSnackBar(
                                        SnackBar(
                                          backgroundColor: purple,
                                          duration: Duration(
                                            milliseconds: 800,
                                          ),
                                          content: Text(
                                            "Successfully deleted the decision!",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                return Container(height: 0, width: 0);
                              },
                            ).toList()
                          ],
                        ),
                      ],
                    );
                  }
                } else {
                  return NoHistory();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

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

class History extends StatelessWidget {
  final Function onPressed;

  History({Key key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    TextStyle _noHistoryTextStyle = TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      height: 1.2,
    );

    TextStyle _noHistoryButtonStyle = TextStyle(
      color: Colors.white,
      fontSize: 24.0,
    );

    return Card(
      color: Color(0xFF202020),
      margin: EdgeInsets.zero,
      elevation: 3.0,
      child: Container(
        padding: EdgeInsets.all(28.0),
        child: Consumer<AppModel>(
          builder: (context, app, other) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 60,
                child: RaisedButton(
                  color: Color(0xFF7665E6),
                  child: Text("NEW DECISION", style: _noHistoryButtonStyle),
                  onPressed: () {
                    FirebaseAnalytics().logEvent(name: "get_started");
                    app.newDecision();
                    Navigator.pushNamed(context, "/Create");
                  },
                ),
              ),
              SizedBox(height: 24.0),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('decisions')
                    .where('udid', isEqualTo: app.udid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("Whoops... Something went wrong!");

                  if (snapshot.hasData) {
                    if (snapshot.data.documents.length == 0) {
                      return Center(
                        child: Text(
                          "Press the button above to start a new Pros & Cons list.\n\nPast decisions will show here.",
                          style: _noHistoryTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data.documents.map(
                            (DocumentSnapshot doc) {
                              final decision = Decision.fromMap(doc.data);
                              return HistoryItem(decision: decision);
                            },
                          ).toList(),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        "Press the button above to start a new Pros & Cons list.\n\nPast decisions will show here.",
                        style: _noHistoryTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _headerStyle = TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w800,
    );
    TextStyle _subheaderStyle = TextStyle(
      fontSize: 18.0,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("PROS & CONS", style: _headerStyle),
        SizedBox(height: 4.0),
        Text("Let's help you make a decision!", style: _subheaderStyle),
      ],
    );
  }
}
