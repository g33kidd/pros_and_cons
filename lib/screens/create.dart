import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/pages/objective.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/pages/results.dart';
import 'package:ads/ads.dart';
import 'package:pros_cons/util.dart';

final Color purp = Color(0xFF7665E6);

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
      appBar: AppBar(
        title: Text(
          "Make a list of Pros & Cons.",
          style: TextStyle(
            color: purp,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      // TODO has this been done right?
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
                Icons.arrow_forward,
                color: purp,
              ),
              label: Text(
                "NEXT",
                style: TextStyle(
                  color: purp,
                ),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                pageController.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
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
            if (page == 2) {
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
            ResultsPage(
              decision: decision,
            ),
          ],
        ),
      ),
    );
  }
}
