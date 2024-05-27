import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }

  Future<Map<String, dynamic>> getUserById(String id) async {
    Map<String, dynamic> userData =
        await db.collection("users").doc(id).get().then((DocumentSnapshot doc) {
      return doc.data() as Map<String, dynamic>;
    });

    return userData;
  }

  Future<String> editUser(String id, String status) async {
    try {
      await db.collection("users").doc(id).update({"status": status});

      return "Successfully edited!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
