import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String udid;
  String username;
  String bio;
  bool subscriber;

  Profile({this.udid, this.username, this.bio, this.subscriber});

  static Future<Profile> fromPath(String path) async {
    final profile = await FirebaseFirestore.instance
        .collection('profiles')
        .doc(
          path,
        )
        .get();

    final data = profile.data();

    return Profile(
      username: data['username'],
      bio: data['bio'],
      udid: data['udid'],
      subscriber: data['subscriber'],
    );
  }
}
