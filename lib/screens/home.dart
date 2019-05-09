import 'package:flutter/material.dart';

TextStyle _infoTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
  color: Colors.grey,
);

TextStyle _header = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w600,
  color: Color(0xFF2DBB54),
);

/// TODO: cleanup the flex columns on here a bit, it's a little wonky right now
/// but it definitely works. Should be more flexible.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Text("PROS & CONS", style: _header),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Let's help you make a decision!",
                    style: _infoTextStyle,
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    "This app will ask for a list of pros and cons, then will determine a score based on the importance of each item you have given. The score will help you make a decision.",
                    style: _infoTextStyle,
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    "Get started below!",
                    style: _infoTextStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/create");
              },
              child: Container(
                margin: EdgeInsets.all(20.0),
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF8F79EB),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Get Started!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
