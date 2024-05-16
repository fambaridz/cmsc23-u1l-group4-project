import 'package:flutter/material.dart';

class AdminOrgDetailsPage extends StatelessWidget {
  const AdminOrgDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization"),
      ),
      body: Center(
        child: Text('Org Details'),
      ),
    );
  }
}
