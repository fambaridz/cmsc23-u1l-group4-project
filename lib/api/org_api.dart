import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addOrg(Map<String, dynamic> org) async {
    try {
      await db.collection("users").add(org);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllOrgs() {
    return db.collection("users").where("userType", isEqualTo: "organization").snapshots();
  }

  DocumentReference<Map<String, dynamic>> getOrg(String id) {
    return db.collection("users").doc(id);
  }

  Future<String> deleteOrg(String id) async {
    try {
      await db.collection("users").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // Future<String> editOrg(String id, String status) async {
  //   try {
  //     await db.collection("users").doc(id).update({"status": status});
  //     return "Successfully edited!";
  //   } on FirebaseException catch (e) {
  //     return "Error in ${e.code}: ${e.message}";
  //   }
  // }

  // Donation 
  Stream<QuerySnapshot> getDonationsByOrg(String orgId) {
    return db.collection("donations").where("org", isEqualTo: orgId).snapshots();
  }
}
