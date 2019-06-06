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

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/funky-lines.png"),
              repeat: ImageRepeat.repeat,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.4),
                BlendMode.dstATop,
              ),
            ),
          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
