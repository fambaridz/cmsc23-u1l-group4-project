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
                width: double.infinity,
                height: 400,
                color: Colors.lightBlue[200],
                child: Center(
                    child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                        height: 160,
                        width: 160,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/profile.png')))),
                    const SizedBox(height: 20),
                    const Text(
                      "Jane Smith",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "@therealJS",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text("Contact Number: ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          Text("Address/es: ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ))),
            const SizedBox(height: 25),
            const Text("Donations by Donor A",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
          ],
        ),
      ),
    );
  }
}
