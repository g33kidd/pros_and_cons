import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/display.dart';
import 'package:pros_cons/util.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';

class SuggestionScreen extends StatefulWidget {
  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  String title;
  String body;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "SUGGESTIONS",
      needsSafeArea: true,
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Title",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              onChanged: (s) {
                setState(() {
                  title = s;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "Message Box",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 10,
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
                  await Firestore.instance.collection('suggestions').add(
                    {
                      'title': title,
                      'suggestion': body,
                    },
                  );
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
