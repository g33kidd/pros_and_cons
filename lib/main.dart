import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/screens/about.dart';
import 'package:pros_cons/screens/home.dart';
import 'package:pros_cons/screens/create.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (_) => AppModel(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pros & Cons",
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      home: HomeScreen(),
      routes: {
        "/Home": (_) => HomeScreen(),
        "/Create": (_) => CreateScreen(),
        "/About": (_) => AboutScreen(),
      },
    );
  }
}
