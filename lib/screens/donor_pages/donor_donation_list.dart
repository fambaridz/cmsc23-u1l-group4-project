import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/screens/donor_pages/donor_drawer.dart';

class DonorDonationList extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DonorDonationList({Key? key, required this.userData}) : super(key: key);

  @override
  State<DonorDonationList> createState() => _DonorDonationListState();
}

class _DonorDonationListState extends State<DonorDonationList> {

  User? user;
  late List<Map<String, dynamic>?> donations = [];

  @override
  void initState() {
    super.initState();
    getUserDonations();
  }

  Future<void> getUserDonations() async {
    user = context.read<UserAuthProvider>().user;
    if (user != null) {
      final userDonations = await context.read<DonationListProvider>().getDonationByUserId(user!.uid);
      setState(() {
        donations = userDonations;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DonorDrawer(userData: widget.userData),
      appBar: AppBar(
        title: Text("Donations"),
      ),
      body: Center(
        child: donations.isEmpty
              ? Text("No ongoing donations found.")
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: donations.length,
                  itemBuilder: (context, index) {
                    var donation = donations[index];
                    var category = donation?['category'];
                    return GestureDetector(
                      onTap: () {
                        print(donation);
                        Navigator.pushNamed(context, "/donor-donation-details", arguments: donation);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 250, 250, 250),
                        ),
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(20),
                          title: Text(
                            category!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}