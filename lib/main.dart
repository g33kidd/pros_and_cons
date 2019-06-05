import 'package:flutter/material.dart';
import 'package:pros_cons/screens/home.dart';
import 'package:pros_cons/screens/create.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        "/Home": (_) => HomeScreen(),
        "/Create": (_) => CreateScreen(),
        // TODO create an about screen with donation
        // "/About": (_) => AboutScreen(),
      },
    );
  }
}
