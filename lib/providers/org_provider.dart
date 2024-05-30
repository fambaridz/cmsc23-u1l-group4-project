
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/api/org_api.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:flutter/material.dart';

class OrganizationProvider with ChangeNotifier{
  FirebaseOrgAPI firebaseService = FirebaseOrgAPI();
  late Stream<QuerySnapshot> _organizationStream;

  OrganizationProvider(){
    fetchOrgs();
  }

  Stream<QuerySnapshot> get organization => _organizationStream;

  void fetchOrgs(){
    _organizationStream = firebaseService.getAllOrgs();
    notifyListeners();
  }

  Future<Organization> getOrg(String id) async{
    DocumentReference<Map<String, dynamic>> org = firebaseService.getOrg(id);
    DocumentSnapshot<Map<String, dynamic>> orgSnapshot = await org.get();
    return Organization.fromJson(orgSnapshot.data()!);
  }

  Future<String> addOrg(Organization newOrganization) async{
    String message = await firebaseService.addOrg(newOrganization.toJson(newOrganization));
    notifyListeners();
    return message;
  }

  // Future<String> updateOrganization(Organization newOrganization) async{
  //   String message = await firebaseService.editOrg(newOrganization.toJson(newOrganization));
  //   notifyListeners();
  //   return message;
  // }

  Future<String> deleteOrg(Organization organization) async{
    String message = await firebaseService.deleteOrg(organization.id!);
    notifyListeners();
    return message;
  }
}