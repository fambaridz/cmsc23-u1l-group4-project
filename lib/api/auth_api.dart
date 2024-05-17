import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? getUser() {
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot userDoc = await db.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        return "User not found.";
      } else {
        return userDoc['user_type'];
      }
    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return e.message;
      } else if (e.code == 'invalid-credential') {
        return e.message;
      } else {
        return "Failed at ${e.code}: ${e.message}";
      }
    }
  }

  Future<String?> signUpDonor(String user_type, String name, String username, String email, String password, String address, String contact_num) async {
    UserCredential credential;
    try {

      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // add user to firestore after successful sign up in authentication by getting the user id
      await db.collection('users').doc(credential.user!.uid).set({
        'user_type': user_type,
        'name': name,
        'username': username,
        'email': email,
        'address': address,
        'contact_num': contact_num,
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return e.message;
      } else if (e.code == 'invalid-email') {
        return e.message;
      } else if (e.code == 'invalid-password') {
        return e.message;
      } else {
        return "Failed at ${e.code}: ${e.message}";
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}