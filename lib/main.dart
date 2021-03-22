import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:preferences/preferences.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/schema/user.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: purple,
    ),
  );

  /// impl test
  /// impl test
  /// impl test
  /// impl test

  // Here initialize the Campfire with the Camp intended.
  await Campfire.init(
    camp: "pros-cons-1324",
    options: CampOptions(
      alwaysOn: true,
    ),
  );

  ///
  ///

  // TODO replace this with the Hive stuff.
  await PrefService.init();
  PrefService.setDefaultValues({"dark_mode": false});

  await Hive.initFlutter();
  await Hive.openBox('settings');

  // Setting up Preferences Service and Firebase.
  await Firebase.initializeApp();

  // Setup RevenueCat stuff.
  // Anonymous user at first.
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup("AGTBDHMmKYctttiVbGOIrKnAdjsoglzl");

  // Go! Go! Go!
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends HookWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pros & Cons",
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      home: FirstStop(),
      routes: {},
    );
  }
}

/// Checks what screen the user needs right now.
///
/// TODO at some point, scrap this and implement the AuthWatcher.
/// We really only need to control thef navigator when auth state changes.
class FirstStop extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
