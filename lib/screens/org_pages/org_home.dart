import 'package:cmsc23_project/screens/org_pages/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({super.key});

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  late Map<String, dynamic> userData;
  User? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    if (user != null) {
      context.read<UserAuthProvider>().getUserData(user!.uid).then((value) {
        setState(() {
          userData = value!;
        });
      });
    }

    return Scaffold(
      drawer: OrganizationDrawer(userData: userData),
      appBar: AppBar(
        title: Text("Unsorted Donations"),
      ),
    );
  }
}