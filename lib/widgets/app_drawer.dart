import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);
    final _tileTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: app.darkMode ? Colors.white : Colors.black,
    );

    final iconColor = Colors.grey;

    return Drawer(
      elevation: 2.0,
      child: Container(
        color: app.darkMode ? Colors.grey[900] : Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  Container(
                    /// Need the exact size of a AppBar.
                    padding: EdgeInsets.symmetric(
                      vertical: 6.0,
                    ),
                    margin: EdgeInsets.only(bottom: 6.0),
                    color: purple,
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            color: (!app.darkMode)
                                ? Colors.grey[900]
                                : Colors.white,
                            icon: (!app.darkMode)
                                ? Icon(Icons.brightness_2)
                                : Icon(Icons.brightness_7),
                            onPressed: () {
                              app.switchTheme();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.settings),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, "/Settings");
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                    child: NewDecisionButton(
                      onPressed: () {
                        FirebaseAnalytics().logEvent(
                          name: "new_decision",
                          parameters: {
                            'position': "app_drawer",
                          },
                        );
                        Navigator.popAndPushNamed(context, "/Create");
                      },
                    ),
                  ),
                  // ListTile(
                  //   title: Text("Decision History", style: _tileTextStyle),
                  //   subtitle: Text("View previous decisions"),
                  //   leading: Icon(Icons.history),
                  //   onTap: () {},
                  // ),
                  // Divider(),
                  ListTile(
                    title: Text("Share with Friends", style: _tileTextStyle),
                    leading: Icon(Icons.share, color: iconColor),
                    dense: true,
                    onTap: () async {
                      FirebaseAnalytics().logEvent(name: "social_share");
                      await Share.share(
                        "I just weighed my pros and cons on this app. Checkout PROS & CONS on the Play Store! http://bit.ly/32sRgb9",
                        subject: "PROS & CONS",
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Leave a Review & Rate", style: _tileTextStyle),
                    leading: Icon(Icons.rate_review, color: iconColor),
                    dense: true,
                    onTap: () async {
                      await launch("market://details?id=com.g33kidd.pros_cons");
                    },
                  ),
                  ListTile(
                    title: Text("Suggest Feature", style: _tileTextStyle),
                    leading: Icon(Icons.chat_bubble_outline, color: iconColor),
                    dense: true,
                    onTap: () => Navigator.pushNamed(context, "/Suggest"),
                  ),
                  ListTile(
                    title: Text("Contact Developer", style: _tileTextStyle),
                    leading: Icon(Icons.email, color: iconColor),
                    dense: true,
                    onTap: () => openEmail(context),
                  ),
                  // Divider(),
                  // ListTile(
                  //   title: Text("Learn More", style: _tileTextStyle),
                  //   leading: Icon(Icons.info_outline, color: iconColor),
                  //   dense: true,
                  //   onTap: () => openEmail(context),
                  // ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "REMOVE ADS",
                      style: _tileTextStyle.copyWith(color: Colors.red),
                    ),
                    dense: true,
                    subtitle: Text(
                      "Support the developer without ads!",
                      style: TextStyle(
                        color: !app.darkMode ? Colors.black : Colors.grey,
                      ),
                    ),
                    leading: Icon(Icons.block, color: Colors.red),
                    onTap: () =>
                        Navigator.popAndPushNamed(context, "/RemoveAds"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Footer(),
            ),
          ],
        ),
      ),
    );
  }

  void openEmail(BuildContext context) async {
    final email = "g33kidd.studios@gmail.com";
    final subject = "[DEV CONTACT REQUEST] PROS & CONS";
    final body = "Write your request here...";
    final url = Uri.encodeFull("mailto:$email?subject=$subject&body=$body");
    final launchable = await canLaunch(url);
    if (launchable) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("No app supports opening email links."),
        ),
      );
    }
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
    final darkMode = Provider.of<AppModel>(context).darkMode;
    TextStyle _footerStyle = TextStyle(
      fontSize: 12.0,
      color: !darkMode ? Colors.grey[850] : Colors.grey,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Made with ❤️ by g33kidd.", style: _footerStyle),
        Text("Version $version+$buildNumber", style: _footerStyle),
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
