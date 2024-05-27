import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../GlobalContextService.dart';
import '../../providers/user_provider.dart';
import 'admin_drawer.dart';

class AdminApprovalsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminApprovalsPage({super.key, required this.userData});

  @override
  State<AdminApprovalsPage> createState() => _AdminApprovalsPageState();
}

class _AdminApprovalsPageState extends State<AdminApprovalsPage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> usersStream = GlobalContextService
        .navigatorKey.currentContext!
        .watch<UserListProvider>()
        .user;
    return Scaffold(
        drawer: AdminDrawer(
          userData: widget.userData,
        ),
        appBar: AppBar(
          title: const Text("Pending Organization Accounts"),
        ),
        body: StreamBuilder(
            stream: usersStream,
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

              // Filter the users to only display organizations with a pending status
              var orgList = [];
              for (int index = 0; index < snapshot.data!.docs.length; index++) {
                var user =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;
                if (user['userType'] == 'Organization' && !user['status']) {
                  orgList.add(user);
                }
              }

              return ListView.builder(
                itemCount: orgList.length,
                itemBuilder: ((context, index) {
                  var organization = orgList[index];
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                organization['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/admin/aproval-info",
                                      arguments:
                                          organization); // pass organization info for displaying
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
                              ))));
                }),
              );
            }));
  }
}
