import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pros_cons/screens/chat/message.dart';

import '../display.dart';
import 'chat/message_builder.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1000), () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Experimental Chat"),
            content: Text(
              "This is a new feature that is being actively developed in production! You may use it as you wish, but please note this is not the final product and data may be deleted.\n\nThis new place is a chat room for everybody to get help with decisions or just chat for the heck of it.\n\nYou can share a decision with anybody by using the + icon at the bottom. More features will be coming to this section soon and with more updated designs.",
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Lobby Chat", style: Display.titleStyle),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('messages')
                    .document('lobby')
                    .collection('lobby')
                    .orderBy('timestamp', descending: true)
                    .limit(50)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: snapshot.data.documents.length,
                      reverse: true,
                      controller: listScrollController,
                      itemBuilder: (context, index) {
                        return Message(snapshot.data.documents[index]);
                      },
                    );
                  }
                },
              ),
            ),
            MessageBuilder(
              onSendMessage: () {
                listScrollController.animateTo(
                  0.0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
