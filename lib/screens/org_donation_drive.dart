import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:flutter/material.dart';

class OrganizationDonationDrivePage extends StatefulWidget {
  const OrganizationDonationDrivePage({super.key});

  @override
  State<OrganizationDonationDrivePage> createState() => _OrganizationDonationDrivePageState();
}

class _OrganizationDonationDrivePageState extends State<OrganizationDonationDrivePage> {
  final DonationDrive donationDrive = DonationDrive(
    id: "1",
    name: "Donation Drive Name",
    status: "Open",
    organization: Organization(
      id: "1",
      name: "Organization Name",
      aboutUs: "We are organization. We do organization things. Please donate",
      status: true
    ),
    donationList: [Donation(
      id: "1",
      donor: "Juan Dela Cruz",
      category: "Clothes",
      weight: 5,
      address: "1234 Donations St.",
      contactNo: "09123456789",
      pickUpDateTime: "2022-12-31 23:59:59",
      dropOffDateTime: "2023-01-01 00:00:00",
      photo: "photo.jpg"
    )]
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donations"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            Text('Name: ${donationDrive.name}'),
            Text('Organization: ${donationDrive.organization.name}'),
            Text('Status: ${donationDrive.status}'),
            ListView.builder(
            shrinkWrap: true,
            itemCount: donationDrive.donationList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("Status"),
                title: Text(donationDrive.donationList[index].id),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/org-home/donation/details", arguments: {
                      "details": donationDrive.donationList[index]
                    });
                  },
                  child: Text("View"),
                ),
              );
            }
          ),
          ],) 
        )
      )
    );
  }
}