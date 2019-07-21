import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/pages/objective.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/pages/results.dart';
import 'package:ads/ads.dart';
import 'package:pros_cons/util.dart';
import 'package:provider/provider.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final bool testing = true;
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
      () => Provider.of<AppModel>(context).decision.arguments.clear(),
    );
  }

  bool get isNext => (_page < 2);

  @override
  void dispose() {
    _ads.hideFullScreenAd();
    _ads.hideBannerAd();
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "PROS & CONS",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        elevation: 0,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        backgroundColor: purple,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple.withAlpha(87),
        elevation: 0.0,
        child: Container(
          height: 55.0,
          padding: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Align(
            alignment: Alignment.bottomRight,
            child: FlatButton.icon(
              icon: Icon(
                isNext ? Icons.arrow_forward : Icons.save,
                color: purple,
                size: 24.0,
              ),
              label: Text(
                isNext ? "NEXT" : "SAVE & FINISH",
                style: TextStyle(
                  color: purple,
                  fontSize: 22.0,
                ),
              ),
              onPressed: () async {
                if (_page == 2) {
                  _ads.showFullScreenAd(
                    state: this,
                    adUnitId: "ca-app-pub-4846566520266716/9132707300",
                    testing: testing,
                  );
                  setState(() {
                    loading = true;
                  });
                  await Future.delayed(Duration(seconds: 5));
                  FirebaseAnalytics().logEvent(name: "finish", parameters: {
                    'descision_objective': app.decision.objective,
                    'decision_cons': app.decision.getCons.length,
                    'decision_pros': app.decision.getPros.length,
                    'decision_mood': describeEnum(app.decision.mood),
                  });
                  await Firestore.instance.collection('decisions').add(
                    {
                      'objective': app.decision.objective,
                      'mood': describeEnum(app.decision.mood),
                      'udid': app.udid,
                      'score': app.decision.buildScore(),
                      'created': app.decision.created.toUtc(),
                      'arguments': app.decision.arguments
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
                  app.newDecision();
                  Navigator.pop(context);

                  // Navigator.popAndPushNamed(context, "/Home");
                } else {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  pageController.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOutExpo,
                  );
                }
              },
            ),
          ),
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
