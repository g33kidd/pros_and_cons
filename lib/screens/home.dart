import 'package:ads/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/display.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/app_drawer.dart';
import 'package:pros_cons/widgets/history_item.dart';
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

    _ads = Ads(
      "ca-app-pub-4846566520266716~9709175425",
      testing: testing,
      bannerUnitId: "ca-app-pub-4846566520266716/6725176015",
    );

    // Move to CheckAuth screen, in prep for user accounts?
    FirebaseAuth.instance.signInAnonymously().then((data) {
      print(data.providerId);
      print("Logged in anonymously!");
      _ads.showBannerAd(testing: testing);
      Future.delayed(Duration(seconds: 5), () => _ads.hideBannerAd());
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
    final _snackKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _snackKey,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("PROS & CONS", style: Display.titleStyle),
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
                              app.newDecision();
                              Navigator.pushNamed(context, "/Create");
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView(
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
