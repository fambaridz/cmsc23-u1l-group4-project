import 'package:cmsc23_project/model/donor.dart';
import 'package:flutter/material.dart';

class AdminDonorDetailsPage extends StatelessWidget {
  const AdminDonorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var donor = Donor(
      id: '1',
      userType: 'Donor',
      name: 'Jane Smith',
      username: '@therealJS',
      email: 'anEmail@email.com',
      addresses: {'Main branch': '123 Datu st., Brgy. Magiliw'},
      contactNum: '+63 123 123 4567',
    );

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
                          Text("Contact Number: ${donor.contactNum}",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                          Text("Address/es: ${donor.addresses}",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                          const SizedBox(height: 25)
                        ],
                      ),
                    )
                  ],
                ))),
            const SizedBox(height: 25),
            Text("Donations by ${donor.name}",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // itemCount: ,
                  itemBuilder: (context, index) {
                    // final donation = donor.donations[index];

                    return const ListTile(
                      title: Text('Text'
                          // donation,
                          // style: const TextStyle(fontSize: 20),
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
