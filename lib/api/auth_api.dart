import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/model/donor.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseAuthAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  User? getUser() {
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot userDoc = await db.collection('users').doc(uid).get();
    if (!userDoc.exists) {
      return null;
    } else {
      return userDoc.data() as Map<String, dynamic>;
    }
  }

  Future<Map<String, dynamic>> getUserById(String id) async {
    Map<String, dynamic> userData =
        await db.collection("users").doc(id).get().then((DocumentSnapshot doc) {
      return doc.data() as Map<String, dynamic>;
    });

    return userData;
  }
  
  Future<List<Map<String, dynamic>>?> getOrganizations() async {
    QuerySnapshot<Map<String, dynamic>> organizations = await db
        .collection('users')
        .where('userType', isEqualTo: 'Organization')
        .get();

    if (organizations.size == 0) {
      // No organizations found
      return null;
    } else {
      // Put all retrieved organizations in a list
      List<Map<String, dynamic>> organizationList = [];
      for (var doc in organizations.docs) {
        organizationList.add(doc.data());
      }

      return organizationList;
    }
  }

  Future<List<Map<String, dynamic>>?> getDonors() async {
    QuerySnapshot<Map<String, dynamic>> donors = await db
        .collection('users')
        .where('userType', isEqualTo: 'Donor')
        .get();

    if (donors.size == 0) {
      // No donors found
      return null;
    } else {
      // Put all the retrieved donors in a list
      List<Map<String, dynamic>> donorList = [];
      for (var doc in donors.docs) {
        donorList.add(doc.data());
      }

      return donorList;
    }
  }

  Future<Map<String, dynamic>> approveOrganization(String id) async {
    try {
      await db.collection("users").doc(id).update({"isVerified": true});

      return {'success': true};
    } on FirebaseException catch (e) {
      return {'success': false, 'message': "Error in ${e.code}: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      DocumentSnapshot userDoc =
          await db.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        return {"error": "User not found"};
      } else if ((userDoc.data() as Map<String, dynamic>)['isVerified'] ==
              false &&
          (userDoc.data() as Map<String, dynamic>)['userType'] ==
              "Organization") {
        return {"error": "Account not yet verified. Please wait for approval."};
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

  Future<Map<String, dynamic>?> signUpDonor(
      Donor donor, String password) async {
    UserCredential credential;

    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: donor.email,
        password: password,
      );

      // add user to firestore after successful sign up in authentication by getting the user id
      await db.collection('users').doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'userType': donor.userType,
        'name': donor.name,
        'username': donor.username,
        'email': donor.email,
        'addresses': donor.addresses,
        'contactNum': donor.contactNum,
      });

      // Retrieve the user data after creation and return it
      DocumentSnapshot userDoc =
          await db.collection('users').doc(credential.user!.uid).get();
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

  Future<Map<String, dynamic>?> signUpOrg(
      Organization org, String password, File file) async {
    try {
      // Create user with email and password
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: org.email,
        password: password,
      );

      // Upload file to Firebase Storage
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child('proofs/${file.path.split('/').last}')
          .putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Write user data to Firestore
      await db.collection('users').doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'userType': org.userType,
        'name': org.name,
        'aboutUs': org.aboutUs,
        'username': org.username,
        'email': org.email,
        'addresses': org.addresses,
        'contactNum': org.contactNum,
        'status': org.status,
        'isVerified': org.isVerified,
        'photoUrl': downloadUrl,
      });

      // Retrieve the user data after creation and return it
      DocumentSnapshot userDoc =
          await db.collection('users').doc(credential.user!.uid).get();
      return userDoc.data() as Map<String, dynamic>?;
    } on FirebaseAuthException catch (e) {
      return {"error": e.message};
    } on FirebaseException catch (e) {
      return {"error": e.message};
    } catch (e) {
      return {"error": e.toString()};
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
