import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/pages/objective.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/pages/results.dart';
import 'package:ads/ads.dart';
import 'package:pros_cons/util.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final decision = Decision();

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0,
  );

  @override
  void initState() {
    super.initState();
    Ads.init("ca-app-pub-4846566520266716~9709175425", testing: true);
  }

  @override
  void dispose() {
    Ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          decoration: funkyLinesDecoration,
          child: PageView(
            // physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (page) {
              if (page == 3) {
                Ads.showFullScreenAd(
                  adUnitId: "ca-app-pub-4846566520266716/1402723263",
                );
              }
            },
            children: <Widget>[
              ObjectivePage(
                decision: decision,
                pageController: pageController,
              ),
              OptionListPage(
                pageController: pageController,
                onChanged: (list) {
                  setState(() {
                    decision.pros = list;
                  });
                },
              ),
              OptionListPage(
                pageController: pageController,
                onChanged: (list) {
                  setState(() {
                    decision.cons = list;
                  });
                },
              ),
              ResultsPage(
                decision: decision,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
