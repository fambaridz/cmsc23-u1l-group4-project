import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:flutter/material.dart';

class OrganizationDetails extends StatelessWidget {
  final Map<String, dynamic> userData;
  const OrganizationDetails({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final List<DonationDrive> donationDriveList = [
      
    ];
    // var details = info["details"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userData['name'],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "About Us",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    userData['aboutUs'],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Divider(),
                                  SizedBox(height: 20),
                                  Text(
                                    "Donation Drives",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: donationDriveList.isEmpty
                                        ? const Text(
                                            "No donation drives available")
                                        : ListView(
                                            padding: const EdgeInsets.all(10),
                                            children: donationDriveList
                                                .map((donationDrive) =>
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            "/org-home/donation-drive/details",
                                                            arguments: {
                                                              "details":
                                                                  donationDrive
                                                            });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.grey[100],
                                                        ),
                                                        margin:
                                                            EdgeInsets.all(3),
                                                        child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          leading:
                                                              FractionallySizedBox(
                                                            heightFactor: 1,
                                                            widthFactor: 0.25,
                                                            child: Icon(
                                                              donationDrive
                                                                      .status
                                                                  ? Icons
                                                                      .check_circle
                                                                  : Icons
                                                                      .cancel,
                                                              color:
                                                                  donationDrive
                                                                          .status
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                              size: 50,
                                                            ),
                                                          ),
                                                          title: Text(
                                                            donationDrive.name,
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
