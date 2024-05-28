import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'admin_drawer.dart';

class AdminDonorsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminDonorsPage({super.key, required this.userData});

  @override
  State<AdminDonorsPage> createState() => _AdminDonorsPageState();
}

class _AdminDonorsPageState extends State<AdminDonorsPage> {
  late List<Map<String, dynamic>> donors = [];

  @override
  void initState() {
    super.initState();
    getVerifiedOrganizations();
  }

  void getVerifiedOrganizations() async {
    List<Map<String, dynamic>>? donorList =
        await context.read<UserAuthProvider>().getDonors();

    if (donorList != null) {
      setState(() {
        donors = donorList;
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
                                donor['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/admin/donor-info",
                                      arguments: donor);
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
