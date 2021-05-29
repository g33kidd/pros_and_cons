import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/widgets/app_drawer.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';
import 'package:pros_cons/widgets/history_item.dart';
import 'package:pros_cons/widgets/no_history.dart';
import 'package:provider/provider.dart';

import '../util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd bannerAd = BannerAd(
    adUnitId: "ca-app-pub-4846566520266716/6725176015",
    size: AdSize.banner,
    request: AdRequest(
      keywords: [
        "decisions",
        "business",
        "mobile",
        "life coach",
        "mental health"
      ],
      nonPersonalizedAds: false,
    ),
    listener: BannerAdListener(
      onAdClosed: (ad) => print(ad),
      onAdFailedToLoad: (ad, error) {
        print(error);
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppModel>(context);
    final query = FirebaseFirestore.instance
        .collection('decisions')
        .where('udid', isEqualTo: app.udid)
        .orderBy('created', descending: true)
        .snapshots();

    return AppScaffold(
      title: "PROS & CONS",
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.chat_bubble_outline),
          onPressed: () => {Navigator.pushNamed(context, "/Chat")},
        ),
      ],
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: query,
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          return HistoryBuilder(snapshot: snapshot);
        },
      ),
    );
  }
}

class HistoryBuilder extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;
  HistoryBuilder({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasError) {
      return Center(
        child: Text("Whoops... there was an error!"),
      );
    }

    if (snapshot.hasData) {
      return HistoryList(
        documents: snapshot.data.docs,
      );
    }

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
    final decisions = Provider.of<DecisionsModel>(context);

    if (documents.length > 0)
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              left: 12.0,
              right: 12.0,
            ),
            child: NewDecisionButton(
              onPressed: () {
                FirebaseAnalytics().logEvent(
                  name: "new_decision",
                  parameters: {'position': "history_list"},
                );
                decisions.newDecision();
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
                  ScaffoldMessenger.of(context).showSnackBar(
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
