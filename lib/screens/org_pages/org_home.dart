import 'package:cmsc23_project/providers/donation_drive_provider.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/screens/org_pages/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cmsc23_project/constants/donation_status_map.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({super.key});

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  late Map<String, dynamic> userData;
  User? user;
  List<Map<String, dynamic>> unsortedDonations = [];
  Map<String, String> unsortedDonors = {};
  List<Map<String, dynamic>> orgDonationDrives = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserAndDonations();
    });
  }

  void getUserAndDonations() async {
    user = context.read<UserAuthProvider>().user;
    if (user != null) {
      final data =
          await context.read<UserAuthProvider>().getUserData(user!.uid);
      setState(() {
        userData = data!;
      });
      await getUnsortedDonations();
      await getUnsortedDonationDonors();
      await getOrgDonationDrives();
    }
  }

  Future<void> getUnsortedDonations() async {
    if (user != null) {
      List<Map<String, dynamic>>? donationList = await context
          .read<DonationListProvider>()
          .getUnsortedDonationsByOrgId(user!.uid);

      if (donationList != null) {
        setState(() {
          unsortedDonations = donationList;
        });
      }
    }
  }

  Future<void> getUnsortedDonationDonors() async {
    if (user != null) {
      List<Map<String, dynamic>>? donorList =
          await context.read<UserAuthProvider>().getDonors();

      if (donorList != null) {
        setState(() {
          unsortedDonors = {};
          for (var donor in donorList) {
            unsortedDonors[donor['id']] = donor['name'];
          }
        });
      }
    }
  }

  editDonationStatus(String donationId, int status) async {
    await context.read<DonationListProvider>().editDonation(donationId, status);
    await getUnsortedDonations();
  }

  Future<void> getOrgDonationDrives() async {
    if (user != null) {
      List<Map<String, dynamic>>? donationDrives = await context
          .read<DonationDriveProvider>()
          .getAllDonationDrivesByOrg(user!.uid);
      if (donationDrives != null) {
        setState(() {
          orgDonationDrives = donationDrives;
        });
      }
    }
  }

  sendDonationToDonationDrive(String donationId, String donationDriveId) async {
    await context
        .read<DonationListProvider>()
        .sendDonationToDonationDrive(donationId, donationDriveId);
    await getUnsortedDonations();
    await receiveDonation(donationDriveId, donationId);
  }

  receiveDonation(String donationDriveId, String donationId) async {
    await context
        .read<DonationDriveProvider>()
        .receiveDonation(donationDriveId, donationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: user != null ? OrganizationDrawer(userData: userData) : null,
      appBar: AppBar(
        title: Text("Unsorted Donations"),
      ),
      body: Center(
        child: unsortedDonations.isEmpty
            ? const Text(
                textAlign: TextAlign.center,
                "No donations are available at the moment. Please check back later.",
              )
            : ListView(
                padding: const EdgeInsets.all(10),
                children: unsortedDonations
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
                                        // print(donation);
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
                                "${unsortedDonors[donation['donorId']] ?? "Unknown"}\n${donation['pickupOrDropoff']}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              trailing: FractionallySizedBox(
                                heightFactor: 1,
                                widthFactor: 0.2,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      print(orgDonationDrives);
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'Send Donation to a Donation Drive'),
                                          content: SingleChildScrollView(child: Container(
                                            height: 300,
                                            width: 300,
                                            child: Center(
                                              child: orgDonationDrives.isNotEmpty ? ListView(
                                                children: orgDonationDrives
                                                    .map((donationDrive) =>
                                                        ListTile(
                                                          title: Text(
                                                              donationDrive[
                                                                  'name']),
                                                          subtitle: Text(
                                                              donationDrive[
                                                                  'status'] ? "Open" : "Closed"),
                                                          trailing: TextButton(
                                                            onPressed: () {
                                                              sendDonationToDonationDrive(
                                                                  donation[
                                                                      'id'],
                                                                  donationDrive[
                                                                      'id']);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              "Send",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ): Text("No donation drives available at the moment."),
                                            ),
                                          ),),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        ),
                                      );
                                      // print(donation);
                                    });
                                  },
                                  icon: Icon(Icons.local_shipping),
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
