import 'package:flutter/material.dart';

import 'admin_drawer.dart';

class AdminApprovalsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminApprovalsPage({super.key, required this.userData});

  @override
  State<AdminApprovalsPage> createState() => _AdminApprovalsPageState();
}

class _AdminApprovalsPageState extends State<AdminApprovalsPage> {
  final List<String> approvals = [
    'Organization A',
    'Organization B',
    'Organization C',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AdminDrawer(userData: widget.userData),
        appBar: AppBar(
          title: const Text("Pending Organization Accounts"),
        ),
        body: Center(
          child: approvals.isEmpty
              ? const Text("No pending accounts for approval.")
              : ListView(
                  padding: const EdgeInsets.all(10),
                  children: approvals
                      .map((approval) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                approval,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/admin/approval-info");
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
