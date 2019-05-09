import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/pages/objective.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/pages/results.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final decision = Decision();

  // TODO not quite sure if I need this yet.
  // TextEditingController _nameTextController = TextEditingController(
  //   text: "",
  // );

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            ObjectivePage(
              decision: decision,
              pageController: pageController,
            ),
            OptionListPage(
              decision: decision,
              pageController: pageController,
              title: "Now let's make a list of pros.",
              onChanged: (list) {
                setState(() {
                  decision.pros = list;
                });
              },
              description:
                  "This is a list of positive effects this might have on your life. Use the button to add as many as you like, but try to aim for at least 5.",
            ),
            OptionListPage(
              decision: decision,
              pageController: pageController,
              onChanged: (list) {
                setState(() {
                  decision.cons = list;
                });
              },
              title: "Now let's make a list of cons.",
              description:
                  "This is a list of negative effects this might have on your life. Use the button to add as many as you like, but try to aim for at least 5.",
            ),
            ResultsPage(
              decision: decision,
            ),
            Container(
              child: FlatButton(
                child: Text(
                  "${decision.objective} Objective! ${decision.mood} Mood!",
                ),
                onPressed: () {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
            Container(
              child: FlatButton(
                child: Text("Page 2"),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("This is the last page!"),
                  ));
                  // pageController.animateToPage(
                  //   2,
                  //   duration: Duration(milliseconds: 200),
                  //   curve: ElasticInCurve(),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
