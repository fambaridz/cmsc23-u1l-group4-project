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

  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot userDoc = await db.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        return {"error": "User not found"};
      } else {
        return userDoc.data() as Map<String, dynamic>;
      }
    
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return {"error": e.message};
      } else if (e.code == 'invalid-credential') {
        return {"error": e.message};
      } else {
        return {"error": "Failed at ${e.code}: ${e.message}"};
      }
    }
  }

  Future<Map<String, dynamic>?> signUpDonor(String user_type, String name, String username, String email, String password, String address, String contact_num) async {
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

      // Retrieve the user data after creation and return it
      DocumentSnapshot userDoc = await db.collection('users').doc(credential.user!.uid).get();
      return userDoc.data() as Map<String, dynamic>;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return {"error": e.message};
      } else if (e.code == 'invalid-email') {
        return {"error": e.message};
      } else if (e.code == 'invalid-password') {
        return {"error": e.message};
      } else {
        return {"error": "Failed at ${e.code}: ${e.message}"};
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}