import 'package:ads/ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/widgets/app_drawer.dart';
import 'package:pros_cons/widgets/history_item.dart';
import 'package:pros_cons/widgets/no_history.dart';
import 'package:provider/provider.dart';

import '../util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Ads _ads;

  @override
  void initState() {
    super.initState();
    setupAds();
  }

  setupAds() {
    _ads = Ads(
      "ca-app-pub-4846566520266716~9709175425",
      testing: false,
      bannerUnitId: "ca-app-pub-4846566520266716/6725176015",
    );

    _ads.showBannerAd(
      anchorOffset: 50.0,
    );

    Future.delayed(Duration(seconds: 10), () => _ads.hideBannerAd());
  }

  @override
  void dispose() {
    _ads.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);
    final query = Firestore.instance
        .collection('decisions')
        .where('udid', isEqualTo: app.udid)
        .orderBy('created', descending: true)
        .snapshots();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("PROS & CONS"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () => {Navigator.pushNamed(context, "/Chat")},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: query,
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) =>
            HistoryBuilder(snapshot: snapshot),
      ),
    );
  }
}

class HistoryBuilder extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  HistoryBuilder({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError)
      return Center(
        child: Text("Whoops... there was an error!"),
      );

    if (snapshot.hasData)
      return HistoryList(
        documents: snapshot.data.documents,
      );

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class HistoryList extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  HistoryList({Key key, this.documents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);

    if (documents.length > 0)
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 12.0,
              left: 12.0,
              right: 12.0,
            ),
            child: NewDecisionButton(
              onPressed: () {
                FirebaseAnalytics().logEvent(
                  name: "new_decision",
                  parameters: {
                    'position': "history_list",
                  },
                );
                app.newDecision();
                Navigator.pushNamed(context, "/Create");
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12.0),
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) => HistoryItem(
                snapshot: documents[index],
                onDelete: () async {
                  Navigator.pop(context, true);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: purple,
                      duration: Duration(
                        milliseconds: 800,
                      ),
                      content: Text(
                        "Successfully deleted the decision!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                  await documents[index].reference.delete();
                },
              ),
            ),
          ),
        ],
      );

    return NoHistory();
  }
}
