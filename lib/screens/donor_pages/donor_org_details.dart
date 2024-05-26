import 'package:flutter/material.dart';

class DonorOrgDetailsPage extends StatelessWidget {
  final Map<String, String> donationDriveMap = {
    'Donation Drive A': 'Description for Donation Drive A',
    'Donation Drive B': 'Description for Donation Drive B',
    'Donation Drive C': 'Description for Donation Drive C',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Organization Details",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.lightBlue[400],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
              orgProfile,
              const SizedBox(height: 30),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              Text(
                "Donation Drives",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.lightBlue[400],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              donationDrive,
            ],
          ),
        ),
      ),
    );
  }

  Widget get orgProfile => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Organization Name:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Organization A",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Text(
            "Address/es: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            flex: 3,
            child: Text(
              "1234 Street, Barangay, City, Province",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Contact Number: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "09123456789",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    ],
  );

  Widget get donationDrive => donationDriveMap.isEmpty
    ? Center(child: const Text("No donation drives available."))
    : ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: donationDriveMap.length,
        itemBuilder: (context, index) {
          final drive = donationDriveMap.keys.elementAt(index);
          final description = donationDriveMap.values.elementAt(index);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.all(20),
              title: Text(
                drive,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      );
}
