import 'package:cmsc23_project/screens/org_pages/org_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/providers/donation_drive_provider.dart';

class OrganizationDonationDrivePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const OrganizationDonationDrivePage({super.key, required this.userData});

  @override
  State<OrganizationDonationDrivePage> createState() => _OrganizationDonationDrivePageState();
}

class _OrganizationDonationDrivePageState extends State<OrganizationDonationDrivePage> {

  User? user;
  late List<Map<String, dynamic>?> donationDriveList = [];

  @override
  void initState() {
    super.initState();
    getOrgDonationDrives();
  }

  Future<void> getOrgDonationDrives() async {
    user = context.read<UserAuthProvider>().user;
    if (user != null) {
      final orgDonationDrives = await context.read<DonationDriveProvider>().getAllDonationDrivesByOrg(user!.uid);
      if (orgDonationDrives != null)
      setState(() {
        donationDriveList = orgDonationDrives;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OrganizationDrawer(userData: widget.userData,),
      appBar: AppBar(
        title: Text("Donation Drives"),
      ),
      body: Center(
        child: donationDriveList.isEmpty
          ? const Text("No donation drives available.")
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: donationDriveList.length,
              itemBuilder: (context, index) {
                var donationDrive = donationDriveList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/org-home/donation-drive/details", arguments: donationDrive);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                    ),
                    margin: EdgeInsets.all(3),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(20),
                      leading: FractionallySizedBox(
                        heightFactor: 1,
                        widthFactor: 0.25,
                        child: Icon(
                          donationDrive!['status'] ? Icons.inventory : Icons.local_shipping,
                          color: donationDrive['status'] ? Colors.green : Colors.red,
                          size: 50,
                        ),
                      ),
                      title: Text(
                        donationDrive['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/org-home/donation-drive/add", arguments: widget.userData);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightBlue[200],
      ),
    );
  }
}