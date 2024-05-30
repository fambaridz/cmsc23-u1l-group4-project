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
      final data = await context.read<UserAuthProvider>().getUserData(user!.uid);
      setState(() {
        userData = data!;
      });
      await getUnsortedDonations();
    }
  }

  Future<void> getUnsortedDonations() async {
    if (user != null) {
      List<Map<String, dynamic>>? donationList = await context.read<DonationListProvider>().getUnsortedDonationsByOrgId(user!.uid);

      if (donationList != null) {
        setState(() {
          unsortedDonations = donationList;
        });
      }
    }
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
                      Navigator.pushNamed(context, "/org-home/donation/details", arguments: donation);
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
                          widthFactor: 0.4,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                donation['status'] = donation['status'] == 5 ? 1 : donation['status'] + 1;
                              });
                            },
                            child: Text(
                              statusMap[donation['status']]!["text"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: statusMap[donation['status']]!["color"] as Color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            )
                          ),
                        ),
                        title: Text(
                          donation['category'],
                          style: TextStyle(
                            fontSize: 20,
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