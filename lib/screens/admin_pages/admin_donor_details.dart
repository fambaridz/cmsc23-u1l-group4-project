import 'package:cmsc23_project/model/donor.dart';
import 'package:flutter/material.dart';

class AdminDonorDetailsPage extends StatelessWidget {
  const AdminDonorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var donor = Donor(
        id: '1',
        name: 'Jane Smith',
        username: '@therealJS',
        password: 'thisisapassword',
        address: '123 Datu st., Brgy. Magiliw',
        contactNo: '+63 123 123 4567',
        donations: [
          'Donation 1',
          'Donation 2',
          'Donation 3',
          'Donation 4',
          'Donation 5',
          'Donation 6'
        ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donor"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: Colors.lightBlue[200],
                child: Flexible(
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
                    Text(
                      donor.name,
                      style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      donor.username,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Text("Contact Number: ${donor.contactNo}",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                          Text("Address/es: ${donor.address}",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                          const SizedBox(height: 25)
                        ],
                      ),
                    )
                  ],
                )))),
            const SizedBox(height: 25),
            const Text("Donations by Donor A",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: donor.donations.length,
                  itemBuilder: (context, index) {
                    final donation = donor.donations[index];

                    return ListTile(
                      title: Text(
                        donation,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
