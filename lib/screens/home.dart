import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _infoTextStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      height: 1.2,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "PROS & CONS",
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: "RobotoCondensed",
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/create");
                },
                child: Container(
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
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
