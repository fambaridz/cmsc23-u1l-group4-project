import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../GlobalContextService.dart';
import '../../providers/user_provider.dart';
import 'admin_drawer.dart';

class AdminDonorsPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminDonorsPage({super.key, required this.userData});

  @override
  State<AdminDonorsPage> createState() => _AdminDonorsPageState();
}

class _AdminDonorsPageState extends State<AdminDonorsPage> {
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
          title: const Text("All Donors"),
        ),
        body: Center(
            child: StreamBuilder(
                stream: usersStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text("Error encountered! ${snapshot.error}"));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return const Text("No donors available.");
                  }

                  // Filter the users to only display donors
                  var donorList = [];
                  for (int index = 0;
                      index < snapshot.data!.docs.length;
                      index++) {
                    var user = snapshot.data?.docs[index].data()
                        as Map<String, dynamic>;
                    if (user['userType'] == 'Donor') {
                      donorList.add(user);
                    }
                  }

                  return ListView.builder(
                    itemCount: donorList.length,
                    itemBuilder: ((context, index) {
                      var donor = donorList[index];

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
                                          arguments:
                                              donor); // pass the donor info for displaying
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
                })));
  }
}
