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

  Future<List<Map<String, dynamic>>> getAllDonationDrivesByOrg(String orgId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection("donationDrives").where('orgId', isEqualTo: orgId).get();
    List<Map<String, dynamic>> donationDrives = [];
    for (var doc in querySnapshot.docs) {
      var donationDrive = doc.data();
      donationDrive['id'] = doc.id;
      donationDrives.add(donationDrive);
    }
    print(donationDrives);
    return donationDrives;
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

  Future<List<Map<String, dynamic>>> getDonationDriveByOrgId(
      String orgId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection("donationDrives")
        .where("orgId", isEqualTo: orgId)
        .get();

    List<Map<String, dynamic>> donationDrives = [];
    for (var doc in querySnapshot.docs) {
      donationDrives.add(doc.data());
    }

    return donationDrives;
  }

  // Future<String> editDonationDrive(String id, String status) async {
  //   try {
  //     await db.collection("users").doc(id).update({"status": status});
  //     return "Successfully edited!";
  //   } on FirebaseException catch (e) {
  //     return "Error in ${e.code}: ${e.message}";
  //   }
  // }

  Future<String> receiveDonation(String id, String donationId) async {
    try {
      final docSnapshot = await db.collection("donationDrives").doc(id).get();
      final donationList = docSnapshot.data()!['donationList'];
      donationList.add(donationId);

      await db.collection("donationDrives").doc(id).update({"donationList": donationList});
      return "Successfully edited!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
