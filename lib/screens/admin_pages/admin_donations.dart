import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/donation.dart';
import 'admin_drawer.dart';

class AdminDonationsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminDonationsPage({super.key, required this.userData});

  @override
  State<AdminDonationsPage> createState() => _AdminDonationsPageState();
}

class _AdminDonationsPageState extends State<AdminDonationsPage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationsStream =
        context.watch<DonationListProvider>().donation;
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
                child: Text("Error encountered! ${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No donations found."),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                Donation donation = Donation.fromJson(
                    snapshot.data?.docs[index].data() as Map<String, dynamic>);
              }),
            );
          }),
    );
  }
}
