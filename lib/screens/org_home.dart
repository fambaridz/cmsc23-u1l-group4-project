import 'package:cmsc23_project/model/organization.dart';
import 'package:cmsc23_project/screens/org_drawer.dart';
import 'package:flutter/material.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({Key? key}) : super(key: key);

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  
  final Organization organization = Organization(
    id: "1",
    name: "Organization Name",
    aboutUs: "We are organization. We do organization things. Please donate",
    status: true
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organization Home"),
      ),
      drawer: OrganizationDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(children: [
                TextButton(onPressed:() { 
                  Navigator.pushNamed(context, "/org-home/donation-drive"); 
                 }, child: Text('Donation Drives')),
                TextButton(onPressed:() { 
                  Navigator.pushNamed(context, "/org-home/donation"); 
                  }, child: Text('Donations')),
                TextButton(
                  onPressed:() { 
                    Navigator.pushNamed(context, "/org-home/profile", arguments: {
                      "details": organization
                    });
                  },
                  child: Text('Profile'))
              ],)
        ),
      )
    );
  }
}