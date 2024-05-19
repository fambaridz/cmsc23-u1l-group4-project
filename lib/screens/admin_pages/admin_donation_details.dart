import 'package:cmsc23_project/model/donation.dart';
import 'package:flutter/material.dart';

class AdminDonationDetailsPage extends StatelessWidget {
  const AdminDonationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _addresses = ['address1, address2'];
    var donation = Donation(
        id: '1',
        donor: 'Donor A',
        category: 'Food',
        weight: '2 kg',
        addresses: _addresses,
        contactNo: '+63 123 123 4567',
        pickUpDateTime: 'April 4, 2030',
        dropOffDateTime: 'April 15, 2030',
        status: 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation"),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            width: double.infinity,
            height: 100,
            color: Colors.lightBlue[200],
            child: Center(
                child: Column(
              children: [
                Text(
                  "Donation by:",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "${donation.donor}",
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ],
            ))),
        SizedBox(height: 30),
        Text("Donation Information",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline)),
        SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Category:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation.category}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Weight:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation.weight}",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              Text("Address/es:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(_addresses[index]));
                },
              ),
              SizedBox(height: 10),
              Text("Contact number:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation.contactNo}",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              Text("Pick up:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation.pickUpDateTime}",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              Text("Drop off:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation.dropOffDateTime}",
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        )
      ])),
    );
  }
}
