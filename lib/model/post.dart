import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pros_cons/model/profile.dart';

class Post {
  String text;
  Timestamp created;
  DocumentReference _profile;
  Profile profile;

  static Query all() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('created', descending: false);
  }

  Post({this.text, this.created, profileRef}) {
    this._profile = FirebaseFirestore.instance.doc(profileRef);
  }

  void loadProfile() async {
    this.profile = await Profile.fromPath(_profile.path);
  }

  static insert(Map<String, dynamic> data) async {}

  static Future<Post> fromSnapshot(QueryDocumentSnapshot snapshot) async {
    final data = snapshot.data();
    final profileReference = Profile.fromPath(data['user_id']);
    return Post(
      text: data['text'],
      created: data['created'],
      profileRef: profileReference,
    );
  }
}
