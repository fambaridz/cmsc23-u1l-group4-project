import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:cmsc23_project/screens/org_pages/org_drawer.dart';
import 'package:flutter/material.dart';

class OrganizationDonationDrivePage extends StatefulWidget {
  const OrganizationDonationDrivePage({super.key});

  @override
  State<OrganizationDonationDrivePage> createState() =>
      _OrganizationDonationDrivePageState();
}

class _OrganizationDonationDrivePageState
    extends State<OrganizationDonationDrivePage> {
  final statusMap = {
    1: {"text": "PENDING", "color": Colors.orange},
    2: {"text": "CONFIRMED", "color": Color.fromARGB(255, 247, 206, 70)},
    3: {"text": "FOR\n PICK-UP", "color": Color.fromARGB(255, 147, 217, 78)},
    4: {"text": "COMPLETED", "color": Colors.green},
    5: {"text": "CANCELLED", "color": Color.fromARGB(255, 215, 63, 63)},
  };

  final List<DonationDrive> donationDriveList = [
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OrganizationDrawer(),
      appBar: AppBar(
        title: Text("Donation Drives"),
      ),
      body: Center(
        child: donationDriveList.isEmpty
            ? const Text("No donation drives available")
            : ListView(
                padding: const EdgeInsets.all(10),
                children: donationDriveList
                    .map((donationDrive) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/org-home/donation-drive/details",
                                arguments: {"details": donationDrive});
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
                                  donationDrive.status
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: donationDrive.status
                                      ? Colors.green
                                      : Colors.red,
                                  size: 50,
                                ),
                              ),
                              title: Text(
                                donationDrive.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, "/org-home/donation-drive/add",
          //     arguments: donationDriveList[0].organization);
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