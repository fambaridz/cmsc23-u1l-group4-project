import 'package:flutter/material.dart';

import 'admin_drawer.dart';

class AdminDonationsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminDonationsPage({super.key, required this.userData});

  @override
  State<AdminDonationsPage> createState() => _AdminDonationsPageState();
}

class _AdminDonationsPageState extends State<AdminDonationsPage> {
  final List<String> donations = [
    'Donation A',
    'Donation B',
    'Donation C',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AdminDrawer(
          userData: widget.userData,
        ),
        appBar: AppBar(
          title: const Text("All Donations"),
        ),
        body: Center(
          child: donations.isEmpty
              ? const Text("No donations available.")
              : ListView(
                  padding: const EdgeInsets.all(10),
                  children: donations
                      .map((donation) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                donation,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/admin/donation-info");
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
                          ))
                      .toList(),
                ),
        ));
  }
}
