import 'package:flutter/material.dart';

import 'admin_drawer.dart';

class AdminDonorsPage extends StatefulWidget {
  const AdminDonorsPage({super.key});

  @override
  State<AdminDonorsPage> createState() => _AdminDonorsPageState();
}

class _AdminDonorsPageState extends State<AdminDonorsPage> {
  final List<String> donors = [
    'Donor A',
    'Donor B',
    'Donor C',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const AdminDrawer(),
        appBar: AppBar(
          title: const Text("All Donors"),
        ),
        body: Center(
          child: donors.isEmpty
              ? const Text("No donors available.")
              : ListView(
                  padding: const EdgeInsets.all(10),
                  children: donors
                      .map((donor) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                donor,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/admin/donor-info");
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
