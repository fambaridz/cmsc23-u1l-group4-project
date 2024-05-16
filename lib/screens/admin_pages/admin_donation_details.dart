import 'package:flutter/material.dart';

class AdminDonationDetailsPage extends StatelessWidget {
  const AdminDonationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation"),
      ),
      body: Center(
        child: Text('Donation Details'),
      ),
    );
  }
}
