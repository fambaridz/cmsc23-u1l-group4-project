import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonationDrive(Map<String, dynamic> donationDrive) async {
    try {
      await db.collection("donationDrives").add(donationDrive);

      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonationDrives() {
    return db.collection("donationDrives").snapshots();
  }

  Stream<QuerySnapshot> getAllDonationDrivesByOrg(String orgId) {
    return db.collection("donationDrives").where("orgId", isEqualTo: orgId).snapshots();
  }

  DocumentReference<Map<String, dynamic>> getDonationDrive(String id) {
    return db.collection("donationDrives").doc(id);
  }

  Future<String> deleteDonationDrive(String id) async {
    try {
      await db.collection("donationDrives").doc(id).delete();

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
}
