import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/screens/chat/message.dart';
import 'package:pros_cons/util.dart';

// TODO reimplement the decision selection when creating a message.

class MessageBuilder extends StatefulWidget {
  final Function onSendMessage;

  MessageBuilder({Key key, this.onSendMessage}) : super(key: key);

  @override
  _MessageBuilderState createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  Function onSendMessage;
  Decision decision;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = useProvider(themeProvider).dark;
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
                      final app = useProvider(appProvider);
                      final topPadding = MediaQuery.of(context).padding.top;
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 32,
                        ),
                        color: purple,
                        child: StreamBuilder(
                          stream: Firestore.instance
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
                              if (snapshot.data.documents.length != 0) {
                                return ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    var _decision = Decision.fromSnapshot(
                                      snapshot.data.documents[index],
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

  sendMessage() async {
    if (textEditingController.text.trim() != '') {
      var text = textEditingController.text.trim();
      var docRef = FirebaseFirestore.instance
          .collection('messages')
          .doc('lobby')
          .collection('lobby')
          .doc();

      await FirebaseFirestore.instance.runTransaction((transaction) async {
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

class NewMessageBuilder extends HookWidget {
  final Function onSendMessage;

  NewMessageBuilder({
    Key key,
    @required this.onSendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chat = useProvider(chatProvider);
    final darkMode = useProvider(themeProvider).dark;
    final msgTextController = useTextEditingController();
    final focusNode = useFocusNode();

    sendMessage() {
      chat.sendMessage(msgTextController.value.text.trim());
      msgTextController.clear();
      onSendMessage();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[100],
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 12),
              Flexible(
                child: TextField(
                  controller: msgTextController,
                  focusNode: focusNode,
                  style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: "What do you want to say?",
                    // contentPadding: EdgeInsets.all(12),
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
      ],
    );
  }
}
