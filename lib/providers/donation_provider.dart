import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/donation.dart';
import '../api/donation_api.dart';
import 'dart:io';

class DonationListProvider with ChangeNotifier {
  FirebaseDonationAPI firebaseService = FirebaseDonationAPI();
  late Stream<QuerySnapshot> _donationsStream;

  DonationListProvider() {
    fetchDonations();
  }

  Stream<QuerySnapshot> get donation => _donationsStream;

  void fetchDonations() {
    _donationsStream = firebaseService.getAllDonations();
    notifyListeners();
  }

  Future<String>? addDonationWithFile(Donation newDonation,
      Map<String, String> donorAddresses, File file) async {
    String message = await firebaseService.addDonationWithFile(
        newDonation.toJson(newDonation), donorAddresses, file);
    notifyListeners();
    return message;
  }

  Future<String>? addDonation(
      Donation newDonation, Map<String, String> donorAddresses) async {
    String message = await firebaseService.addDonation(
        newDonation.toJson(newDonation), donorAddresses);
    notifyListeners();
    return message;
  }

  Future<List<Map<String, dynamic>?>> getDonationByUserId(String uid) async {
    List<Map<String, dynamic>?> message =
        await firebaseService.getDonationByUserId(uid);
    notifyListeners();
    return message;
  }

  Future<String?> editDonation(String donationId, int status) async {
    String? message = await firebaseService.editDonation(donationId, status);
    notifyListeners();
    return message;
  }

  Future<List<Map<String, dynamic>>?> getCompleteDonations() async {
    List<Map<String, dynamic>>? completeDonationList =
        await firebaseService.getCompleteDonations();
    notifyListeners();
    return completeDonationList;
  }

  Future<List<Map<String, dynamic>>?> getDonationsList() async {
    List<Map<String, dynamic>>? donationList =
        await firebaseService.getDonationsList();
    notifyListeners();
    return donationList;
  }

  Future<List<Map<String, dynamic>?>> getDonationByOrgId(String oid) async {
    List<Map<String, dynamic>?> message = await firebaseService.getDonationsByOrgId(oid);
    notifyListeners();
    return message;
  }

  Future<List<Map<String, dynamic>?>> getUnsortedDonationByOrgId(String oid) async {
    List<Map<String, dynamic>?> message = await firebaseService.getUnsortedDonationsByOrgId(oid);
    notifyListeners();
    return message;
  }
}
