import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/user_api.dart';

class UserListProvider with ChangeNotifier {
  FirebaseUserAPI firebaseService = FirebaseUserAPI();
  late Stream<QuerySnapshot> _usersStream;

  UserListProvider() {
    fetchUsers();
  }

  Stream<QuerySnapshot> get user => _usersStream;

  void fetchUsers() {
    _usersStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  void editUser(String id, bool status) async {
    var message = await firebaseService.editUser(id, status);
    print(message);
    notifyListeners();
  }

  Future<Map<String, dynamic>> getUserById(String id) {
    return firebaseService.getUserById(id);
  }
}
