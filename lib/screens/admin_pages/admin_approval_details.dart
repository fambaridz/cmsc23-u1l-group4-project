import 'package:cmsc23_project/GlobalContextService.dart';
import 'package:cmsc23_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminApprovalDetailsPage extends StatelessWidget {
  final Map<String, dynamic>? organization;
  const AdminApprovalDetailsPage({super.key, this.organization});
  @override
  Widget build(BuildContext context) {
    List<String> label = organization!['addresses'].keys.toList();
    List<String> address = organization!['addresses'].value.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization for Approval"),
      ),
      body: Center(
          child: Column(
        children: [
          Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                width: double.infinity,
                height: 100,
                color: Colors.lightBlue[200],
                child: Center(
                  child: Text(
                    "${organization!['name']}",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                )),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("About Us:",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Text("${organization!['aboutUs']}",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                Text("Status:",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                organization!['status']
                    ? Text(
                        "Open",
                        style: TextStyle(fontSize: 20),
                      )
                    : Text(
                        "Closed",
                        style: TextStyle(fontSize: 20),
                      ),
                SizedBox(height: 30),
                Text("Contact Number:",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Text("${organization!['contactNum']}",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                const Text("Address/es:",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: organization!['addresses'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${label[index]}: ",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${address[index]}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                Text("Proof of Legitimacy:",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Image.network(organization!['photoUrl'],
                      fit: BoxFit.cover),
                )
              ],
            )
          ])),
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[400]),
            child: Text(
              "Approve",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              GlobalContextService.navigatorKey.currentContext!
                  .read<UserListProvider>()
                  .editUser(organization!['id'], !organization!['status']);
            },
          )
        ],
      )),
    );
  }
}
