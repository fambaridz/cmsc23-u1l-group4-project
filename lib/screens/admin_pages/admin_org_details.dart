import 'package:cmsc23_project/model/organization.dart';
import 'package:flutter/material.dart';

class AdminOrgDetailsPage extends StatelessWidget {
  const AdminOrgDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var organization = Organization(
        id: '1',
        userType: 'Organizaiton',
        name: 'Organization A',
        aboutUs: 'We are an organization.',
        username: 'anOrg',
        email: 'org@org.com',
        addresses: {'Laguna branch': 'Laguna'},
        contactNum: '091234567890',
        status: true,
        proof: 'image');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization"),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text("${organization.aboutUs}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 50),
            Text("Status:",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            organization.status
                ? Text(
                    "Open",
                    style: TextStyle(fontSize: 20),
                  )
                : Text(
                    "Closed",
                    style: TextStyle(fontSize: 20),
                  )
          ],
        )
      ])),
    );
  }
}
