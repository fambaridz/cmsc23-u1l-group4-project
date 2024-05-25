import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cmsc23_project/api/auth_api.dart';

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

  Future<Map<String, dynamic>?> signUpDonor(String userType, String name, String username, String email, String password, Map<String, String> addresses, String contactNum) async {
    Map<String, dynamic>? message = await authService.signUpDonor( userType, name, username, email, password, addresses, contactNum);
    notifyListeners();
    return message;
  }

  Future<Map<String, dynamic>?> signUpOrg(
      String userType,
      String name,
      String aboutUs,
      String username,
      String email,
      String password,
      Map<String, String> addresses,
      String contactNum) async {
    Map<String, dynamic>? message = await authService.signUpOrg(userType, name,
        aboutUs, username, email, password, addresses, contactNum);
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
