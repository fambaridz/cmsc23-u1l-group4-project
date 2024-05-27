import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_drawer.dart';

class AdminDonationsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminDonationsPage({super.key, required this.userData});

  @override
  State<AdminDonationsPage> createState() => _AdminDonationsPageState();
}

class _AdminDonationsPageState extends State<AdminDonationsPage> {
  late List<Map<String, dynamic>> donations = [];

  @override
  void initState() {
    super.initState();
    getDonationList();
  }

  void getDonationList() async {
    List<Map<String, dynamic>>? donationList =
        await context.read<DonationListProvider>().getDonationsList();

    if (donationList != null) {
      setState(() {
        donations = donationList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AdminDrawer(
          userData: widget.userData,
        ),
        appBar: AppBar(
          title: const Text("All Donations"),
        ),
        body: ListView.builder(
          itemCount: donations.length,
          itemBuilder: ((context, index) {
            Map<String, dynamic> donation = donations[index];

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              margin: EdgeInsets.all(10),
              child: ListTile(
                contentPadding: EdgeInsets.all(20),
                title: Text(
                  "${donation['category']} donation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/admin/donation-info");
                  },
                  child: Text(
                    "View",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
