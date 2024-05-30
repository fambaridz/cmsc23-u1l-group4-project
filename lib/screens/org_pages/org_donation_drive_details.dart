import 'package:cmsc23_project/constants/donation_status_map.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/providers/donation_drive_provider.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationDonationDriveDetails extends StatefulWidget {
  final Map<String, dynamic> donationDrive;
  const OrganizationDonationDriveDetails({super.key, required this.donationDrive});

  @override
  State<OrganizationDonationDriveDetails> createState() => _OrganizationDonationDriveDetailsPageState();
}

class _OrganizationDonationDriveDetailsPageState extends State<OrganizationDonationDriveDetails> {
  List<Map<String, dynamic>> donationList = [];
  Map<String, String> donorMap = {};
  
  @override
  void initState() {
    super.initState();
    getDonations();
    getUnsortedDonationDonors();
  }

  Future<void> getDonations() async {
    List<String>? donationIds = await context.read<DonationDriveProvider>().getDonationsByDonationDriveId(widget.donationDrive['id']);
    if (donationIds != null) {
      for (var id in donationIds) {
        Map<String, dynamic>? donation = await context.read<DonationListProvider>().getDonation(id);
        if (donation != null) {
          donationList.add(donation);
        }
      }
      setState(() {});
      // donationList = donationIds.map((id) => {  }).toList();
    }
  }

  editDonationStatus(String donationId, int status) async {
    await context.read<DonationListProvider>().editDonation(donationId, status);
    getDonations();
  }

  Future<void> deleteDonationDrive() async {
    await context.read<DonationDriveProvider>().deleteDonationDrive(widget.donationDrive['id']);
  }

  Future<void> editDonationDriveStatus() async {
    await context.read<DonationDriveProvider>().editDonationDrive(widget.donationDrive['id'], false);
  }

  Future<void> getUnsortedDonationDonors() async {
    List<Map<String, dynamic>>? donorList =
          await context.read<UserAuthProvider>().getDonors();

      if (donorList != null) {
        setState(() {
          donorMap = {};
          for (var donor in donorList) {
            donorMap[donor['id']] = donor['name'];
          }
        });
      }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.donationDrive['name'] as String),
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
                  widget.donationDrive['status'] ? "Open" : "Closed",
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
                widget.donationDrive['status'] ? ElevatedButton(
                  onPressed: () {
                    
                    setState(() {
                      editDonationDriveStatus();
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Close", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ) : Container(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      deleteDonationDrive();
                      Navigator.pop(context);
                    });
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
            ? const Text(
                textAlign: TextAlign.center,
                "No donations are available at the moment. Please check back later.",
              )
            : ListView(
                padding: const EdgeInsets.all(10),
                children: donationList
                    .map((donation) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/org-home/donation/details",
                                arguments: donation);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(30),
                              leading: FractionallySizedBox(
                                heightFactor: 1,
                                widthFactor: 0.3,
                                child: TextButton(
                                    onPressed: () {
                                      if (donation['status'] >= 4) {
                                        return;
                                      }
                                      setState(() {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'Donation Status Change Confirmation'),
                                            content: const Text(
                                                'Are you sure you want to change the status of this donation?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (donation['status'] == 2 &&
                                                      donation[
                                                              'pickupOrDropoff'] ==
                                                          "Drop-off") {
                                                    //qr code
                                                    donation['status'] = 3;
                                                  }
                                                  editDonationStatus(
                                                      donation['id'],
                                                      ++donation['status']);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    },
                                    child: Text(
                                      statusMap[donation['status']]!["text"]
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: statusMap[
                                              donation['status']]!["color"]
                                          as Color,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                    )),
                              ),
                              title: Text(
                                donation['category'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${donorMap[donation['donorId']] ?? "Unknown"}\n${donation['pickupOrDropoff']}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
        ],
      )),
    );
  }
}
