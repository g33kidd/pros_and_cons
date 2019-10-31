import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

                            if (snapshot.hasData)
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

  sendMessage() {
    if (textEditingController.text.trim() != '') {
      var text = textEditingController.text.trim();
      var docRef = Firestore.instance
          .collection('messages')
          .document('lobby')
          .collection('lobby')
          .document();

      Firestore.instance.runTransaction((transaction) async {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        Map<String, dynamic> values = {
          'user_id': user.uid,
          'text': text,
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString()
        };

        if (decision != null) {
          values.addAll(
            {
              'decision': Firestore.instance
                  .document("decisions/" + decision.documentID)
            },
          );
        }

        // return;
        await transaction.set(docRef, values);
      });

      textEditingController.clear();
      widget.onSendMessage();
    }
  }
}
