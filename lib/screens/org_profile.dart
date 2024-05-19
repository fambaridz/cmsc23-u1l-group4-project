import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:flutter/material.dart';

class OrganizationDetails extends StatelessWidget {
  final Map info;
  const OrganizationDetails(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
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
                weight: '5 lbs',
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
                weight: '10 kg',
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
                weight: '15 kg',
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
                weight: '20 lbs',
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
                weight: '25 lbs',
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
    var details = info["details"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          details.name,
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
                                    details.aboutUs,
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
