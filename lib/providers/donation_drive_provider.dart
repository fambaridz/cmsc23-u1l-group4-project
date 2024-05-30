
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/api/donation_drive_api.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:flutter/material.dart';

class DonationDriveProvider with ChangeNotifier{
  FirebaseDonationDriveAPI firebaseService = FirebaseDonationDriveAPI();
  late Stream<QuerySnapshot> _donationDriveStream;

  DonationDriveProvider(){
    fetchDonationDrives();
  }

  Stream<QuerySnapshot> get donationDrive => _donationDriveStream;

  void fetchDonationDrives(){
    _donationDriveStream = firebaseService.getAllDonationDrives();
    notifyListeners();
  }

  Future<String> addDonationDrive(DonationDrive newDonationDrive) async{
    String message = await firebaseService.addDonationDrive(newDonationDrive.toJson(newDonationDrive));
    notifyListeners();
    return message;
  }

  // Future<String> editDonationDrive(DonationDrive donationDrive) async{
  //   String message = await firebaseService.editDonationDrive(donationDrive.toJson(donationDrive));
  //   notifyListeners();
  //   return message;
  // }

  Future<String> deleteDonationDrive(DonationDrive donationDrive) async{
    String message = await firebaseService.deleteDonationDrive(donationDrive.id!);
    notifyListeners();
    return message;
  }
}