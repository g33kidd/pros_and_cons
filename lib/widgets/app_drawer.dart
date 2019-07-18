import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tileTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
    );

    return Drawer(
      elevation: 2.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0.0),
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          "PROS & CONS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Helping you understand and make better decisions.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18.0,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: purple,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  child: NewDecisionButton(
                    onPressed: () {
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
                  title: Text("Leave a Review & Rate", style: _tileTextStyle),
                  leading: Icon(Icons.rate_review),
                  dense: true,
                  onTap: () async {
                    await launch("market://details?id=com.g33kidd.pros_cons");
                  },
                ),
                ListTile(
                  title: Text("Suggest Feature", style: _tileTextStyle),
                  leading: Icon(Icons.chat_bubble_outline),
                  dense: true,
                  onTap: () => Navigator.pushNamed(context, "/Suggest"),
                ),
                ListTile(
                  title: Text("Contact Developer", style: _tileTextStyle),
                  leading: Icon(Icons.email),
                  dense: true,
                  onTap: () => openEmail(context),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "REMOVE ADS",
                    style: _tileTextStyle.copyWith(color: Colors.red),
                  ),
                  dense: true,
                  subtitle: Text("Support the developer without ads!"),
                  leading: Icon(Icons.block, color: Colors.red),
                  onTap: () => Navigator.popAndPushNamed(context, "/RemoveAds"),
                ),
                // ListTile(
                //   title: Text("Settings", style: _tileTextStyle),
                //   leading: Icon(Icons.settings),
                //   onTap: () => Navigator.popAndPushNamed(context, "/Settings"),
                // )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            child: Footer(),
          ),
        ],
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
    TextStyle _footerStyle = TextStyle(
      fontSize: 12.0,
      color: Colors.grey[850],
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
