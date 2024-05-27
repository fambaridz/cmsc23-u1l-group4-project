import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/GlobalContextService.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/providers/user_provider.dart';
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
  Map<String, dynamic> _donorData = {};
  void getDonor(String id) async {
    Map<String, dynamic> donor = await GlobalContextService
        .navigatorKey.currentContext!
        .read<UserListProvider>()
        .getUserById(id);

    _donorData = donor;
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationsStream = GlobalContextService
        .navigatorKey.currentContext!
        .watch<DonationListProvider>()
        .donation;

    return Scaffold(
        drawer: AdminDrawer(
          userData: widget.userData,
        ),
        appBar: AppBar(
          title: const Text("All Donations"),
        ),
        body: StreamBuilder(
            stream: donationsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text("Error encountered! ${snapshot.error}"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return const Text("No organizations available.");
              }

              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: ((context, index) {
                  var donation =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  getDonor(donation['donorId']);

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text("Donation by: ${_donorData['name']}"),
                    ),
                  );
                }),
              );
            }));
  }
}
