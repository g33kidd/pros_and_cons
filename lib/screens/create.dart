import 'package:firebase_analytics/firebase_analytics.dart';
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

    _ads = Ads("ca-app-pub-4846566520266716~9709175425", testing: true);
    _ads.setFullScreenAd(adUnitId: "ca-app-pub-4846566520266716/1402723263");
    _ads.setBannerAd(adUnitId: "ca-app-pub-4846566520266716/6725176015");
  }

  bool get isNext => (_page < 2);

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "PROS & CONS",
          style: TextStyle(
            color: purple,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8.0,
        child: Container(
          height: 55.0,
          padding: EdgeInsets.all(8.0),
          color: Colors.white,
          child: Align(
            alignment: Alignment.bottomRight,
            child: FlatButton.icon(
              icon: Icon(
                isNext ? Icons.arrow_forward : Icons.done,
                color: purple,
                size: 24.0,
              ),
              label: Text(
                isNext ? "NEXT" : "FINISH",
                style: TextStyle(
                  color: purple,
                  fontSize: 22.0,
                ),
              ),
              onPressed: () {
                if (_page == 2) {
                  FirebaseAnalytics().logEvent(name: "finish", parameters: {
                    'descision_objective': app.decision.objective,
                    'decision_cons': app.decision.getCons.length,
                    'decision_pros': app.decision.getPros.length,
                    'decision_mood': app.decision.mood.toString(),
                  });
                  app.newDecision();
                  Navigator.pushReplacementNamed(context, "/Home");
                } else {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  pageController.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOutQuart,
                  );
                }
              },
            ),
          ),
        ),
      ),
      body: Container(
        decoration: funkyLinesDecoration,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (page) {
            setState(() {
              _page = page;
              if (page == 2) {
                _ads.showFullScreenAd(
                  state: this,
                  adUnitId: "ca-app-pub-4846566520266716/1402723263",
                );
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
