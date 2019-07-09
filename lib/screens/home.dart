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
                History(),
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
      fontSize: 18.0,
      color: Colors.white,
    );
    TextStyle _noHistoryButtonStyle = TextStyle(
      color: Color(0xFF7665E6),
      fontSize: 24.0,
    );

    return Card(
      color: Color(0xFF202020),
      margin: EdgeInsets.zero,
      elevation: 3.0,
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: Consumer<AppModel>(
          builder: (context, app, other) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Looks like you haven't done any pros & cons yet! How about we change that?",
                style: _noHistoryTextStyle,
              ),
              SizedBox(height: 24.0),
              FlatButton(
                child: Text("GET STARTED", style: _noHistoryButtonStyle),
                onPressed: () {
                  Navigator.pushNamed(context, "/Create");
                },
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
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _footerStyle = TextStyle(
      fontSize: 12.0,
      color: Colors.grey[500],
    );

    TextStyle _infoStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text("MORE INFO", style: _infoStyle),
          color: Color(0xFF7665E6),
          onPressed: () {
            Navigator.pushNamed(context, "/About");
          },
        ),
        SizedBox(height: 24.0),
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
}
