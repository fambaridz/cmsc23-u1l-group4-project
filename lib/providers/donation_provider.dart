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

  void addDonationWithFile(Donation newDonation, Map<String, String> donorAddresses, File file) async {
    String message = await firebaseService.addDonationWithFile(newDonation.toJson(newDonation), donorAddresses, file);
    print(message);
    notifyListeners();
  }

  void addDonation(Donation newDonation, Map<String, String> donorAddresses) async {
    String message = await firebaseService.addDonation(newDonation.toJson(newDonation), donorAddresses);
    print(message);
    notifyListeners();
  }
}
