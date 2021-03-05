import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:preferences/preferences.dart';
import 'package:pros_cons/imports.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:pros_cons/screens/create.dart';
import 'package:pros_cons/screens/home.dart';
import 'package:pros_cons/screens/onboard.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'widgets/focus_detector.dart';

void main() async {
  // We want the binding to be initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Setup the Status Bar color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: purple,
    ),
  );

  // Admob

  // Setting up Preferences Service and Firebase.
  await PrefService.init();
  await Firebase.initializeApp();

  // Setup RevenueCat stuff.
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup("AGTBDHMmKYctttiVbGOIrKnAdjsoglzl");

  PrefService.setDefaultValues({"dark_mode": false});

  // Go! Go! Go!
  runApp(
    ProviderScope(
      child: FocusDetector(
        child: App(),
      ),
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
    final themeMode = useProvider(themeProvider).mode;
    print(themeMode);

    return MaterialApp(
      title: "Pros & Cons",
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      themeMode: themeMode,
      theme: defaultTheme,
      darkTheme: defaultDarkTheme,
      home: FirstStop(),
      routes: {
        '/home': (_) => NewHome(),
        '/onboard': (_) => OnBoard(),
        '/create': (_) => CreateScreen(),
      },
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
    final user = useProvider(userProvider);
    final app = useProvider(appProvider);

    if (user.firebaseAuth.currentUser != null) {
      user.syncDevice(app.udid);
      return NewHome();
    } else if (user.firebaseAuth.currentUser == null) {
      return OnBoard();
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
