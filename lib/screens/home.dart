import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
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
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Header(),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 22.0,
                      ),
                      child: History(),
                    ),
                  ),
                ),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _noHistoryTextStyle = TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      height: 1.2,
    );
    TextStyle _noHistoryButtonStyle = TextStyle(
      color: Colors.white,
      fontSize: 24.0,
    );

    return Card(
      color: Color(0xFF202020),
      margin: EdgeInsets.zero,
      elevation: 3.0,
      child: Container(
        padding: EdgeInsets.all(28.0),
        child: Consumer<AppModel>(
          builder: (context, app, other) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Go ahead and press the button below to start a Pros & Cons list. It's very easy!\n\nHistory coming soon!",
                  style: _noHistoryTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                width: double.infinity,
                height: 60,
                child: RaisedButton(
                  color: Color(0xFF7665E6),
                  child: Text("GET STARTED", style: _noHistoryButtonStyle),
                  onPressed: () {
                    FirebaseAnalytics().logEvent(name: "get_started");
                    app.newDecision();
                    Navigator.pushNamed(context, "/Create");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _headerStyle = TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w800,
    );
    TextStyle _subheaderStyle = TextStyle(
      fontSize: 18.0,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("PROS & CONS", style: _headerStyle),
        SizedBox(height: 4.0),
        Text("Let's help you make a decision!", style: _subheaderStyle),
      ],
    );
  }
}

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _footerStyle = TextStyle(
      fontSize: 12.0,
      color: Colors.grey[500],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Made with ❤️ by g33kidd.", style: _footerStyle),
            Text("Version $version+$buildNumber", style: _footerStyle),
          ],
        ),
      ],
    );
  }

  Future getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }
}
