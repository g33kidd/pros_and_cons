import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pros_cons/imports.dart';

class ChatProvider extends ChangeNotifier {
  // Sends a message to the default Lobby Channel.
  void sendMessage(text) async {
    final doc = FirebaseFirestore.instance
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

      transaction.set(doc, values);
    });
  }
}
