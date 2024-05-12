import 'package:flutter/material.dart';

class OrganizationDonationPage extends StatefulWidget {
  const OrganizationDonationPage({super.key});

  @override
  State<OrganizationDonationPage> createState() => _OrganizationDonationPageState();
}

class _OrganizationDonationPageState extends State<OrganizationDonationPage> {
  final List<String> donationList = [
    "Donation 1",
    "Donation 2",
    "Donation 3",
    "Donation 4",
    "Donation 5",
    "Donation 6",
    "Donation 7",
    "Donation 8",
    "Donation 9",
    "Donation 10",
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
            itemCount: donationList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text("Status"),
                title: Text(donationList[index]),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text("View"),
                ),
              );
            })
        ),
      )
    );
  }
}