import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/display.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/pages/objective.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/pages/results.dart';
import 'package:ads/ads.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

import 'create/create_screen_navigation.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  double _page = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0,
  );

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        _page = pageController.page;
      });
    });

    Future.delayed(
      Duration.zero,
      () => Provider.of<DecisionsModel>(context).clearOptions(),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // Transition to the next page in the PageView.
  // Requests focus to remove focus from any text fields the user might be on.
  transitionNextPage() {
    if (_page < 2) {
      FocusScope.of(context).requestFocus(new FocusNode());
      pageController.nextPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutExpo,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppModel, DecisionsModel>(
      builder: (context, app, decisions, child) {
        return AppScaffold(
          title: "PROS & CONS",
          centerTitle: true,
          bottomNavigationBar: CreateScreenNavigation(
            pageController: pageController,
            onAction: () async {
              transitionNextPage();

              if (_page == 1) {
                FirebaseAnalytics().logEvent(name: "review", parameters: {
                  'decision_cons': decisions.conArgs.length,
                  'decision_pros': decisions.proArgs.length,
                  'decision_mood': describeEnum(decisions.decision.mood),
                });
                final user = await FirebaseAuth.instance.currentUser();
                await Decision.insert({
                  'objective': decisions.decision.objective,
                  'mood': describeEnum(decisions.decision.mood),
                  'udid': app.udid,
                  'user_id': user.uid,
                  'score': decisions.decision.buildScore(),
                  'created': decisions.decision.created.toUtc(),
                  'arguments': decisions.decision.argumentsList,
                });
              }

              if (_page == 2) {
                FirebaseAnalytics().logEvent(name: "finish");
                Navigator.pop(context);
              }
            },
          ),
          body: Container(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: <Widget>[
                ObjectivePage(),
                OptionListPage(),
                ResultsPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
