import 'package:flutter/material.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({Key? key}) : super(key: key);

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organization Home"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(children: [
                TextButton(onPressed:() {}, child: Text('Donation Drives')),
                TextButton(onPressed:() { Navigator.pushNamed(context, "/org-home/donation"); }, child: Text('Donations')),
                TextButton(onPressed:() {}, child: Text('Profile')),
              ],)
        ),
      )
    );
  }
}