import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/screens/chat/message.dart';
import 'package:pros_cons/util.dart';
import 'package:provider/provider.dart';

class MessageBuilder extends StatefulWidget {
  final Function onSendMessage;

  MessageBuilder({Key key, this.onSendMessage}) : super(key: key);

  @override
  _MessageBuilderState createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  Decision decision;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<AppModel>(context).darkMode;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: Colors.grey[100],
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: (decision != null)
                    ? Icon(Icons.remove_circle_outline)
                    : Icon(Icons.add_circle_outline),
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                onPressed: () {
                  if (decision != null) {
                    setState(() {
                      decision = null;
                    });
                    return;
                  }

                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      final app = Provider.of<AppModel>(context);
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        color: purple,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('decisions')
                              .where('udid', isEqualTo: app.udid)
                              .orderBy('created', descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError)
                              return Center(
                                child: Text("Whoops... there was an error!"),
                              );

                            if (snapshot.hasData) {
                              if (snapshot.data.docs.length != 0) {
                                return ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) {
                                    var _decision = Decision.fromSnapshot(
                                      snapshot.data.docs[index],
                                    );
                                    return DecisionCard(
                                      _decision,
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          decision = _decision;
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Column(
                                  children: <Widget>[
                                    Text(
                                      "Looks like you don't have decisions to share.\nTry creating one below.",
                                    ),
                                    SizedBox(height: 20.0),
                                    NewDecisionButton(
                                      onPressed: () {
                                        FirebaseAnalytics().logEvent(
                                          name: "new_decision",
                                          parameters: {
                                            'position': "chat_message_builder",
                                          },
                                        );
                                        Navigator.popAndPushNamed(
                                          context,
                                          "/Create",
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              Flexible(
                child: TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: TextStyle(
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: purple),
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                onPressed: () => sendMessage(),
              )
            ],
          ),
        ),
        if (decision != null) DecisionCard(decision),
      ],
    );
  }

  sendMessage() {
    if (textEditingController.text.trim() != '') {
      var text = textEditingController.text.trim();
      var docRef = FirebaseFirestore.instance
          .collection('messages')
          .doc('lobby')
          .collection('lobby')
          .doc();

      FirebaseFirestore.instance.runTransaction((transaction) async {
        User user = FirebaseAuth.instance.currentUser;
        Map<String, dynamic> values = {
          'user_id': user.uid,
          'text': text,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString()
        };

        if (decision != null) {
          values.addAll({
            'decision': FirebaseFirestore.instance
                .doc("decisions/" + decision.documentID)
          });
        }

        // return;
        transaction.set(docRef, values);
        setState(() {
          decision = null;
        });
      });

      textEditingController.clear();
      widget.onSendMessage();
    }
  }
}
