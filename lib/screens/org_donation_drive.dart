import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/model/organization.dart';
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
    DonationDrive(
        id: "1",
        name: "Donation Drive Name",
        status: true,
        organization: Organization(
            id: "1",
            name: "Organization Name",
            aboutUs:
                "We are organization. We do organization things. Please donate",
            status: true),
        donationList: [
          Donation(
              id: "1",
              donor: "Juan Dela Cruz",
              category: "Clothes",
              weight: 5,
              address: "1234 Donations St.",
              contactNo: "09123456789",
              pickUpDateTime: "2022-12-31 23:59:59",
              dropOffDateTime: "2023-01-01 00:00:00",
              photo: "photo.jpg",
              status: 1),
          Donation(
              id: "2",
              donor: "Pedro Penduko",
              category: "Books",
              weight: 10,
              address: "5678 Donations St.",
              contactNo: "09876543210",
              pickUpDateTime: "2022-12-31 23:59:59",
              dropOffDateTime: "2023-01-01 00:00:00",
              photo: "photo.jpg",
              status: 2),
          Donation(
              id: "3",
              donor: "Maria Makiling",
              category: "Food",
              weight: 15,
              address: "91011 Donations St.",
              contactNo: "09123456789",
              pickUpDateTime: "2022-12-31 23:59:59",
              dropOffDateTime: "2023-01-01 00:00:00",
              photo: "photo.jpg",
              status: 3),
          Donation(
              id: "4",
              donor: "Juan Tamad",
              category: "Toys",
              weight: 20,
              address: "121314 Donations St.",
              contactNo: "09876543210",
              pickUpDateTime: "2022-12-31 23:59:59",
              dropOffDateTime: "2023-01-01 00:00:00",
              photo: "photo.jpg",
              status: 4),
          Donation(
              id: "5",
              donor: "Pedro Penduko",
              category: "Clothes",
              weight: 25,
              address: "151617 Donations St.",
              contactNo: "09123456789",
              pickUpDateTime: "2022-12-31 23:59:59",
              dropOffDateTime: "2023-01-01 00:00:00",
              photo: "photo.jpg",
              status: 5),
        ]),
    DonationDrive(
        id: "2",
        name: "DD 2",
        status: false,
        organization: Organization(
            id: "2",
            name: "Organization Name",
            aboutUs:
                "We are organization. We do organization things. Please donate",
            status: true),
        donationList: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
