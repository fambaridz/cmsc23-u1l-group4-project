import 'package:flutter/material.dart';

class AdminDonorDetailsPage extends StatelessWidget {
  const AdminDonorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor"),
      ),
      body: Center(
        child: Text('Donor Details'),
      ),
    );
  }
}
