import 'package:flutter/material.dart';

class OrganizationDetails extends StatelessWidget{
  final Map info;
  const OrganizationDetails(this.info, {super.key});

  @override
  Widget build(BuildContext context){  
    print(info);
    var details = info["details"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donation Details"
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: ${details.name}"),
            Text("About Us: ${details.aboutUs}"),
            Text("Status: ${details.status ? "Open" : "Closed"}"),
          ],
        ),
      ),
    );
  }
}