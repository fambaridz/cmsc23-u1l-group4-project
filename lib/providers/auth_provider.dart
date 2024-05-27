import 'package:cmsc23_project/model/donor.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cmsc23_project/api/auth_api.dart';
import 'dart:io';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> _uStream;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => _uStream;
  User? get user => authService.getUser();

  void fetchAuthentication() {
    _uStream = authService.userSignedIn();
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    Map<String, dynamic>? message = await authService.getUserData(uid);
    notifyListeners();
    return message;
  }

  Future<Map<String, dynamic>> getUserById(String id) {
    notifyListeners();
    return authService.getUserById(id);
  }

  Future<List<Map<String, dynamic>>?> getOrganizations() async {
    List<Map<String, dynamic>>? orgList = await authService.getOrganizations();
    notifyListeners();
    return orgList;
  }

  Future<List<Map<String, dynamic>>?> getDonors() async {
    List<Map<String, dynamic>>? donorList = await authService.getDonors();
    notifyListeners();
    return donorList;
  }

  Future<Map<String, dynamic>> approveOrganization(String id) async {
    Map<String, dynamic> message = await authService.approveOrganization(id);
    notifyListeners();
    return message;
  }

  Future<Map<String, dynamic>?> signUpDonor(
      Donor donor, String password) async {
    Map<String, dynamic>? message =
        await authService.signUpDonor(donor, password);
    notifyListeners();
    return message;
  }

  Future<Map<String, dynamic>?> signUpOrg(
      Organization org, String password, File file) async {
    Map<String, dynamic>? message =
        await authService.signUpOrg(org, password, file);
    notifyListeners();
    return message;
  }

  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    Map<String, dynamic>? message = await authService.signIn(email, password);
    notifyListeners();
    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
