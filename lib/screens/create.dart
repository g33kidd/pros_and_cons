import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/display.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/pages/objective.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/pages/results.dart';
import 'package:ads/ads.dart';
import 'package:provider/provider.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final bool testing = false;
  bool loading = false;
  int _page = 0;
  Ads _ads;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0,
  );

  @override
  void initState() {
    super.initState();

    _ads = Ads(
      "ca-app-pub-4846566520266716~9709175425",
      testing: testing,
    );

    Future.delayed(
      Duration(milliseconds: 300),
      () => Provider.of<DecisionsModel>(context).clearOptions(),
    );
  }

  bool get isNext => (_page < 1);

  String get buttonLabelText {
    if (_page == 0) return "NEXT";
    if (_page == 1) return "SAVE & REVIEW";
    if (_page == 2) return "FINISH";
    return "FINISH";
  }

  @override
  void dispose() {
    _ads.hideFullScreenAd();
    _ads.hideBannerAd();
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decisions = Provider.of<DecisionsModel>(context);
    final app = Provider.of<AppModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("PROS & CONS", style: Display.titleStyle),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                isNext ? Icons.arrow_forward : Icons.save,
                color: Colors.white,
                size: 20.0,
              ),
              label: Text(
                buttonLabelText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () async {
                if (_page < 2) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  pageController.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOutExpo,
                  );
                }

                if (_page == 1) {
                  // TODO idk what to do about this...
                  // Ads don't show up half the time, but when they do it's cancelled because
                  // this is going out of View!
                  _ads.showFullScreenAd(
                    state: this,
                    adUnitId: "ca-app-pub-4846566520266716/9132707300",
                    testing: testing,
                  );
                  // setState(() {
                  //   loading = true;
                  // });
                  // await Future.delayed(Duration(seconds: 5));
                  FirebaseAnalytics().logEvent(name: "review", parameters: {
                    'decision_cons': decisions.conArgs.length,
                    'decision_pros': decisions.proArgs.length,
                    'decision_mood': describeEnum(decisions.decision.mood),
                  });
                  final user = await FirebaseAuth.instance.currentUser();
                  await Firestore.instance.collection('decisions').add(
                    {
                      'objective': decisions.decision.objective,
                      'mood': describeEnum(decisions.decision.mood),
                      'udid': app.udid,
                      'user_id': user.uid,
                      'score': decisions.decision.buildScore(),
                      'created': decisions.decision.created.toUtc(),
                      'arguments': decisions.decision.arguments
                          .map(
                            (a) => {
                              'title': a.title,
                              'importance': a.importance,
                              'type': describeEnum(a.type),
                            },
                          )
                          .toList(),
                    },
                  );
                  // app.newDecision();
                  // Navigator.pop(context);
                  // Navigator.popAndPushNamed(context, "/Home");
                }

                if (_page == 2) {
                  FirebaseAnalytics().logEvent(name: "review");
                  Navigator.pop(context);
                  decisions.newDecision();
                }
              },
            ),
          ],
        ),
      ),
      body: Container(
        // decoration: funkyLinesDecoration,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    _page = page;

                    // TODO this sometimes works, figure out where else to put it and load ads From?
                    // Admob fucking sucks on Flutter...
                    if (_page == 2) {
                      Future.delayed(Duration(milliseconds: 1200), () {
                        _ads.showFullScreenAd();
                      });
                    }
                  });
                },
                children: <Widget>[
                  ObjectivePage(),
                  OptionListPage(),
                  ResultsPage(),
                ],
              ),
      ),
    );
  }
}
