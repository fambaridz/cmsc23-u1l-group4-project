import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/screens/admin_pages/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminOrganizationsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminOrganizationsPage({super.key, required this.userData});

  @override
  State<AdminOrganizationsPage> createState() => _AdminOrganizationsPageState();
}

class _AdminOrganizationsPageState extends State<AdminOrganizationsPage> {
  List<Map<String, dynamic>> organizations = [];

  @override
  void initState() {
    super.initState();
    getVerifiedOrganizations();
  }

  void getVerifiedOrganizations() async {
    List<Map<String, dynamic>>? orgList =
        await context.read<UserAuthProvider>().getOrganizations();

    if (orgList != null) {
      List<Map<String, dynamic>>? verifiedOrgs = [];
      for (var org in orgList) {
        if (org['isVerified']) {
          verifiedOrgs.add(org);
        }
      }

      setState(() {
        organizations = verifiedOrgs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AdminDrawer(
          userData: widget.userData,
        ),
        appBar: AppBar(
          title: const Text("All Organizations"),
        ),
        body: Center(
          child: organizations.isEmpty
              ? const Center(child: Text("No organizations available."))
              : ListView(
                  padding: const EdgeInsets.all(10),
                  children: organizations
                      .map((organization) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                organization['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/admin/organization-info",
                                      arguments: organization);
                                },
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ));
  }
}
