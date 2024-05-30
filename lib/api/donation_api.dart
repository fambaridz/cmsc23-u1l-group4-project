import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonationWithFile(Map<String, dynamic> donation, Map<String, String> donorAddresses, File file) async {
    try {
      // Generate a unique file name using the current timestamp
      String fileName = "${donation["donorId"]}_${donation["category"]}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      TaskSnapshot snapshot = await FirebaseStorage.instance.ref("donation_images/$fileName").putFile(file);
      String url = await snapshot.ref.getDownloadURL();

      await db.collection("donations").add(
        {
          "donorId": donation["donorId"],
          "category": donation["category"],
          "pickupOrDropoff": donation["pickupOrDropoff"],
          "weight": donation["weight"],
          "address": donation["address"],
          "contactNum": donation["contactNum"],
          "pickUpDateTime": donation["pickUpDateTime"],
          "dropOffDateTime": donation["dropOffDateTime"],
          "itemPhotoUrl": url,
        },
      );
      await db.collection("users").doc(donation["donorId"]).update({"addresses": donorAddresses});
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> addDonation(Map<String, dynamic> donation, Map<String, String> donorAddresses) async {
    try {
      await db.collection("donations").add(donation);
      await db.collection("users").doc(donation["donorId"]).update({"addresses": donorAddresses});
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<List<Map<String, dynamic>>> getDonationByUserId(String uid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection("donations").where("donorId", isEqualTo: uid).get();
    
    List<Map<String, dynamic>> donations = [];
    for (var doc in querySnapshot.docs) {
      var donationData = doc.data();
      donationData['uid'] = doc.id;
      donations.add(donationData);
    }

    return donations;
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

  Future<List<Map<String, dynamic>>> getDonationsByOrgId(String oid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection("donations").where((doc) => doc["orgId"] == oid).get();
    
    List<Map<String, dynamic>> donations = [];
    for (var doc in querySnapshot.docs) {
      var donationData = doc.data();
      donationData['oid'] = doc.id;
      donations.add(donationData);
    }

    return donations;
  }

  Future<List<Map<String, dynamic>>> getUnsortedDonationsByOrgId(String oid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db.collection("donations").where((doc) => doc["orgId"] == oid || doc["donationDriveId"] == 'null').get();
    print(querySnapshot);
    List<Map<String, dynamic>> donations = [];
    for (var doc in querySnapshot.docs) {
      var donationData = doc.data();
      donationData['oid'] = doc.id;
      donations.add(donationData);
    }
    print(donations);
    return donations;
  }

}
