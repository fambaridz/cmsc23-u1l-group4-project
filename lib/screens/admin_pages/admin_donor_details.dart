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
        child: Column(
          children: [
            Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/profile.png')))),
            Text("Jane Smith"),
            Text("@therealJS"),
            Text("Address/es: "),
            Text("Contact Number: ")
          ],
        ),
      ),
    );
  }
}
