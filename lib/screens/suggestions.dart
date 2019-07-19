import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/util.dart';

class SuggestionScreen extends StatefulWidget {
  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  String title;
  String body;

  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: purple,
        title: Text("SUGGESTIONS", style: _titleStyle),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(13.0),
                  hintText: "Edit here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(13.0),
                  hintText: "Edit me...",
                  focusColor: purple,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
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
      ),
    );
  }
}
