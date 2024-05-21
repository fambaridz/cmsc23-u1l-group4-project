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

  Future<Map<String, dynamic>?> signUpDonor(String user_type, String name, String username, String email, String password, String address, String contact_num) async {
    Map<String, dynamic>? message = await authService.signUpDonor(user_type, name, username, email, password, address, contact_num);
    notifyListeners();
    return message;
  }

  Future<Map<String, dynamic>?> signUpOrg(String user_type, String name, String username, String email, String password, String address, String contact_num) async {
    Map<String, dynamic>? message = await authService.signUpOrg(user_type, name, username, email, password, address, contact_num);
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