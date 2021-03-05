import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pros_cons/imports.dart';

// class User extends ChangeNotifier {}

class UserProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth;
  String uid;
  String displayName = "Some Username";

  String firebaseErrorCode = "";
  bool hasError = false;

  UserProvider() {
    firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen(this.onAuthStateChanges);
  }

  Future setProfile(Map<String, dynamic> data) async {
    final profileRef = FirebaseFirestore.instance
        .collection('profiles')
        .doc(firebaseAuth.currentUser.uid);

    final profile = await profileRef.get();

    if (profile.exists) {
      await profileRef.update(data);
    } else {
      await profileRef.set(data);
    }
  }

  Future updateProfile(String username) async {
    await this.setProfile({"username": username});
  }

  syncDevice(id) async {
    await this.setProfile({"udid": id});
  }

  void signInAnon() async {
    final authUser = await firebaseAuth.signInAnonymously();
    uid = authUser.user.uid;
    notifyListeners();
  }

  void authenticate(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        try {
          await firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        } on FirebaseAuthException catch (e2) {
          this.firebaseErrorCode = e2.code;
          this.hasError = true;
        }
      } else {
        this.firebaseErrorCode = e.code;
        this.hasError = true;
      }
    }

    notifyListeners();
  }

  void onAuthStateChanges(User user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
    notifyListeners();
  }
}
