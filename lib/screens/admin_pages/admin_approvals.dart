import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'admin_drawer.dart';

class AdminApprovalsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminApprovalsPage({super.key, required this.userData});

  @override
  State<AdminApprovalsPage> createState() => _AdminApprovalsPageState();
}

class _AdminApprovalsPageState extends State<AdminApprovalsPage> {
  List<Map<String, dynamic>> approvals = [];

  @override
  void initState() {
    super.initState();
    getUnverifiedOrganizations();
  }

  void getUnverifiedOrganizations() async {
    List<Map<String, dynamic>>? orgList =
        await context.read<UserAuthProvider>().getOrganizations();

    if (orgList != null) {
      List<Map<String, dynamic>>? unverifiedOrgs = [];
      for (var org in orgList) {
        if (org['isVerified'] == false) {
          unverifiedOrgs.add(org);
        }
      }

      setState(() {
        approvals = unverifiedOrgs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AdminDrawer(userData: widget.userData),
        appBar: AppBar(
          title: const Text("Pending Organization Accounts"),
        ),
        body: Center(
          child: approvals.isEmpty
              ? const Center(child: Text("No pending accounts for approval."))
              : ListView(
                  padding: const EdgeInsets.all(10),
                  children: approvals
                      .map((approval) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/admin/approval-info",
                                arguments: approval);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                approval['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )))
                      .toList(),
                ),
        ));
  }
}
