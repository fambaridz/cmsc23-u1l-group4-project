import 'package:flutter/material.dart';

class AdminApprovalDetailsPage extends StatelessWidget {
  const AdminApprovalDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization for Approval"),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text("Organization details"),
          SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[200]),
            child: Text(
              "Approve",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )
        ],
      )),
    );
  }
}
