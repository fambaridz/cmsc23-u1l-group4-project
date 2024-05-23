import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonation(Map<String, dynamic> donation) async {
    try {
      await db.collection("donations").add(donation);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  DocumentReference<Map<String, dynamic>> getDonation(String id) {
    return db.collection("donations").doc(id);
  }

  Future<String> deleteDonation(String id) async {
    try {
      await db.collection("donations").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> editDonation(String id, String status) async {
    try {
      await db.collection("donations").doc(id).update({"status": status});

      return "Successfully edited!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
