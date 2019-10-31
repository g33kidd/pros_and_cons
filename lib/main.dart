import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/screens/about.dart';
import 'package:pros_cons/screens/ad_free.dart';
import 'package:pros_cons/screens/chat.dart';
import 'package:pros_cons/screens/home.dart';
import 'package:pros_cons/screens/create.dart';
import 'package:pros_cons/screens/settings.dart';
import 'package:pros_cons/screens/suggestions.dart';
import 'package:pros_cons/util.dart';
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

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  void initState() {
    super.initState();
    checkAnonymousLogin();
  }

  Future checkAnonymousLogin() async {
    await Future.delayed(Duration.zero);
    final user = await FirebaseAuth.instance.signInAnonymously();
    await Future.delayed(Duration(milliseconds: 300));
    Provider.of<AppModel>(context).uid = user.uid;
    if (user != null) return await Navigator.pushNamed(context, "/Home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            backgroundColor: Colors.blueGrey[100],
            strokeWidth: 8.0,
          ),
        ),
      ),
    );
  }
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
      home: CheckLogin(),
      theme: ThemeData(
        accentColor: purple,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: purple,
          elevation: 0,
          behavior: SnackBarBehavior.fixed,
        ),
        appBarTheme: AppBarTheme(
          color: purple,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
            ),
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: purple),
        sliderTheme: SliderThemeData(
          activeTrackColor: purple,
          inactiveTrackColor: Colors.black12,
          trackHeight: 6.0,
          valueIndicatorColor: purple,
          thumbColor: purple,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
          overlayColor: purple.withAlpha(52),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
          activeTickMarkColor: Colors.white.withAlpha(25),
          inactiveTickMarkColor: Colors.black.withAlpha(14),
          tickMarkShape: RoundSliderTickMarkShape(
            tickMarkRadius: 3.0,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(16.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(color: purple, width: 2.5),
          ),
        ),
      ),
      routes: {
        "/Home": (_) => HomeScreen(),
        "/Create": (_) => CreateScreen(),
        "/RemoveAds": (_) => AdFreeScreen(),
        "/Settings": (_) => SettingsScreen(),
        "/Chat": (_) => ChatScreen(),
        "/Suggest": (_) => SuggestionScreen(),
        "/About": (_) => AboutScreen(),
      },
    );
  }
}
