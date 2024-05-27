import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
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
  late Map<String, dynamic> donorData;

  void getDonorData(String id) async {
    Map<String, dynamic> donor =
        await context.read<UserAuthProvider>().getUserById(id);
    setState(() {
      donorData = donor;
    });
  }

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
                getDonorData(donation.donorId);

                return ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  title: Text(
                    '${donation.category} from ${donorData['name']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/admin/donation-info");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "View",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
    );
  }
}
