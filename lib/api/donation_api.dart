import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonationWithFile(Map<String, dynamic> donation,
      Map<String, String> donorAddresses, File file) async {
    try {
      // Generate a unique file name using the current timestamp
      String fileName =
          "${donation["donorId"]}_${donation["category"]}_${DateTime.now().millisecondsSinceEpoch}.jpg";
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref("donation_images/$fileName")
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();

      DocumentReference docRef = await db.collection("donations").add(
        {
          "donorId": donation["donorId"],
          "orgId": donation["orgId"],
          "category": donation["category"],
          "pickupOrDropoff": donation["pickupOrDropoff"],
          "weight": donation["weight"],
          "address": donation["address"],
          "contactNum": donation["contactNum"],
          "pickUpDateTime": donation["pickUpDateTime"],
          "dropOffDateTime": donation["dropOffDateTime"],
          "itemPhotoUrl": url,
          "status": donation["status"],
        },
      );
      
      await db.collection("users").doc(donation["donorId"]).update({"addresses": donorAddresses});
      return docRef.id;
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> addDonation(
      Map<String, dynamic> donation, Map<String, String> donorAddresses) async {
    try {
      DocumentReference docRef = await db.collection("donations").add(donation);
      await db.collection("users").doc(donation["donorId"]).update({"addresses": donorAddresses});
      return docRef.id;
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<List<Map<String, dynamic>>> getDonationByUserId(String uid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection("donations").where("donorId", isEqualTo: uid).get();

    List<Map<String, dynamic>> donations = [];
    for (var doc in querySnapshot.docs) {
      var donationData = doc.data();
      if (donationData['status'] != 5) {
        donationData['uid'] = doc.id;
        donations.add(donationData);
      }
    }

    return donations;
  }

  // might delete this if remained unused
  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Future<List<Map<String, dynamic>>?> getDonationsList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('donations').get();

    if (querySnapshot.size == 0) {
      return null;
    } else {
      List<Map<String, dynamic>> donationList = [];
      for (var doc in querySnapshot.docs) {
        donationList.add(doc.data());
      }

      return donationList;
    }
  }

  // might delete this if remained unused
  DocumentReference<Map<String, dynamic>> getDonation(String id) {
    return db.collection("donations").doc(id);
  }

  // might delete this if remained unused
  Future<String> editDonation(String id, int status) async {
    try {
      await db.collection("donations").doc(id).update({"status": status});
      return "Successfully edited!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<List<Map<String, dynamic>>?> getCompleteDonations() async {
    QuerySnapshot<Map<String, dynamic>> completeDonations =
        await db.collection('donations').where('status', isEqualTo: 4).get();

    if (completeDonations.size == 0) {
      // No complete donations found
      return null;
    } else {
      // Put all retrieved complete donations in a list
      List<Map<String, dynamic>> completeDonationList = [];
      for (var doc in completeDonations.docs) {
        completeDonationList.add(doc.data());
      }

      return completeDonationList;
    }
  }

  // might delete this if remained unused
  Future<String> deleteDonation(String id) async {
    try {
      await db.collection("donations").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
