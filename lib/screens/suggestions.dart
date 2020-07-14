import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/util.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class SuggestionScreen extends StatefulWidget {
  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  String title;
  String body;
  String email;

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<AppModel>(context).darkMode;
    return AppScaffold(
      title: "SUGGESTIONS",
      needsSafeArea: true,
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Suggestion/Title",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
              ),
              onChanged: (s) {
                setState(() {
                  title = s;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Email Address",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
              ),
              onChanged: (s) {
                setState(() {
                  email = s;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Message Box",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
              ),
              onChanged: (s) {
                setState(() {
                  body = s;
                });
              },
            ),
            SizedBox(height: 20.0),
            Builder(builder: (context) {
              return RaisedButton.icon(
                icon: Icon(Icons.send),
                label: Text("Send Suggestion"),
                color: purple,
                textColor: Colors.white,
                onPressed: () async {
                  // TODO user ID should go here, so you can DM them eventually.
                  await Firestore.instance.collection('suggestions').add({
                    'title': title,
                    'suggestion': body,
                    'email': email,
                  });
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Thanks for the suggestion!"),
                    ),
                  );
                  Navigator.pop(context, true);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
