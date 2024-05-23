import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/donation.dart';
import '../api/donation_api.dart';

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

  void addDonation(Donation newDonation) async {
    String message =
        await firebaseService.addDonation(newDonation.toJson(newDonation));
    print(message);
    notifyListeners();
  }
}
