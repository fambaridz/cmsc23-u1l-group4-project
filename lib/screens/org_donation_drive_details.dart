import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:cmsc23_project/screens/org_donation_drive_form.dart';
import 'package:flutter/material.dart';

class OrganizationDonationDriveDetails extends StatefulWidget {
  final Map info;
  const OrganizationDonationDriveDetails(this.info, {super.key});

  @override
  State<OrganizationDonationDriveDetails> createState() =>
      _OrganizationDonationDriveDetailsPageState();
}

class _OrganizationDonationDriveDetailsPageState
    extends State<OrganizationDonationDriveDetails> {
  final statusMap = {
    1: {"text": "PENDING", "color": Colors.orange},
    2: {"text": "CONFIRMED", "color": Color.fromARGB(255, 247, 206, 70)},
    3: {"text": "FOR\n PICK-UP", "color": Color.fromARGB(255, 147, 217, 78)},
    4: {"text": "COMPLETED", "color": Colors.green},
    5: {"text": "CANCELLED", "color": Color.fromARGB(255, 215, 63, 63)},
  };

  final Organization organization = Organization(
      id: "1",
      name: "Organization Name",
      aboutUs: "We are organization. We do organization things. Please donate",
      status: true);

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
  ];

  @override
  Widget build(BuildContext context) {
    final details = widget.info["details"];
    return Scaffold(
      appBar: AppBar(
        title: Text(details.name),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status: ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  details.status ? "Open" : "Closed",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DonationDriveForm(organization);
                    }));
                    setState(() {
                      
                    });
                  },
                  child: Text("Edit", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {"remove": details.id});
                  },
                  child: Text("Remove", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 215, 63, 63),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 20),
          Text(
            "Donations",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.lightBlue[400],
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: donationList.isEmpty
                ? const Text("No donations available")
                : ListView(
                    padding: const EdgeInsets.all(10),
                    children: donationList
                        .map((donation) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/org-home/donation/details",
                                    arguments: {"details": donation});
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
                                    widthFactor: 0.32,
                                    child: TextButton(
                                        onPressed: () {
                                          donation.status = donation.status == 5
                                              ? 1
                                              : donation.status + 1;
                                          setState(() {});
                                        },
                                        child: Text(
                                          statusMap[donation.status]!["text"]
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            // shadows: [
                                            //   Shadow(
                                            //     color: Colors.grey,
                                            //     offset: Offset(0.8, 0.8),
                                            //   ),
                                            // ],
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: statusMap[donation
                                              .status]!["color"] as Color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                        )),
                                  ),
                                  title: Text(
                                    donation.donor,
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
          )
        ],
      )),
    );
  }
}