import 'package:flutter/material.dart';

import '../../model/organization.dart';

class AdminApprovalDetailsPage extends StatelessWidget {
  const AdminApprovalDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    var organization = Organization(
        id: '1',
        name: 'Organization A',
        aboutUs: 'We are an organization.',
        status: false,
        userType: '',
        username: '',
        email: '',
        addresses: {},
        contactNum: '', photoUrl: '', isVerified: false,
        // proof of legitimacy
        );

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
                    "${organization.name}",
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
                Text("${organization.aboutUs}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                Text("Status:",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                organization.status
                    ? Text(
                        "Open",
                        style: TextStyle(fontSize: 20),
                      )
                    : Text(
                        "Closed",
                        style: TextStyle(fontSize: 20),
                      ),
                SizedBox(height: 30),
                Text("Proof of Legitimacy:",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
            onPressed: () {},
          )
        ],
      )),
    );
  }
}
