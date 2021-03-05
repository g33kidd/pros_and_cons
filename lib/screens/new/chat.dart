import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/components/notice.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/screens/chat/message.dart';
import 'package:pros_cons/screens/chat/message_builder.dart';

class ChatPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final notice = useProvider(noticeProvider);
    final stream = FirebaseFirestore.instance
        .collection('messages')
        .doc('lobby')
        .collection('lobby')
        .orderBy('timestamp', descending: true)
        .snapshots();

    final AsyncSnapshot<QuerySnapshot> snapshot = useStream(stream);
    final listScrollController = useScrollController();

    if (snapshot.hasData) {
      final documents = snapshot.data.docs;

      return PageScaffold(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppBar(
              title: Text("#lobby chat"),
              primary: false,
            ),
            // Notice("chat:saves", color: darkPurple),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(12.0),
                itemCount: documents.length,
                reverse: true,
                controller: listScrollController,
                itemBuilder: (context, index) => NewMessage(documents[index]),
              ),
            ),
            NewMessageBuilder(
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
      );
    } else if (snapshot.hasError) {
      print(snapshot.error.toString());
      return Container(
        child: Center(
          child: Text("Something went wrong."),
        ),
      );
    } else {
      print("Something else went wrong.");
      print(snapshot.connectionState);
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
