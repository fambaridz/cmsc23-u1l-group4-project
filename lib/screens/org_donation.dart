import 'package:cmsc23_project/model/donation.dart';
import 'package:flutter/material.dart';

class OrganizationDonationPage extends StatefulWidget {
  const OrganizationDonationPage({super.key});

  @override
  State<OrganizationDonationPage> createState() => _OrganizationDonationPageState();
}

class _OrganizationDonationPageState extends State<OrganizationDonationPage> {
  final List<Donation> donationList = [
    Donation(
      id: "1",
      donor: "Juan Dela Cruz",
      category: "Clothes",
      weight: 5,
      address: "1234 Donations St.",
      contactNo: "09123456789",
      pickUpDateTime: "2022-12-31 23:59:59",
      dropOffDateTime: "2023-01-01 00:00:00",
      photo: "photo.jpg"
    ),
    Donation(
      id: "2",
      donor: "Pedro Penduko",
      category: "Books",
      weight: 10,
      address: "5678 Donations St.",
      contactNo: "09876543210",
      pickUpDateTime: "2022-12-31 23:59:59",
      dropOffDateTime: "2023-01-01 00:00:00",
      photo: "photo.jpg"
    ),
    Donation(
      id: "3",
      donor: "Maria Makiling",
      category: "Food",
      weight: 15,
      address: "91011 Donations St.",
      contactNo: "09123456789",
      pickUpDateTime: "2022-12-31 23:59:59",
      dropOffDateTime: "2023-01-01 00:00:00",
      photo: "photo.jpg"
    )
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donations"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: donationList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("Status"),
                title: Text(donationList[index].id),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/org-home/donation/details", arguments: {
                      "details": donationList[index]
                    });
                  },
                  child: Text("View"),
                ),
              );
            }
          ),
        )
      )
    );
  }
}