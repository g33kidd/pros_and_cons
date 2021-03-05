import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/util.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';

class SuggestionScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    final body = useTextEditingController();
    final title = useTextEditingController();
    final darkMode = useProvider(themeProvider).dark;
    final user = useProvider(userProvider);

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
              controller: title,
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
              controller: email,
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
              controller: body,
              style: TextStyle(
                color: darkMode ? Colors.white : Colors.black,
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
                  await FirebaseFirestore.instance
                      .collection('suggestions')
                      .add({
                    'title': title,
                    'suggestion': body,
                    'user_id': user.firebaseAuth.currentUser.uid,
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
