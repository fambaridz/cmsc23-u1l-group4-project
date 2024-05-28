import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDonationDetailsPage extends StatefulWidget {
  final Map<String, dynamic> donationData;
  const AdminDonationDetailsPage({super.key, required this.donationData});

  @override
  State<AdminDonationDetailsPage> createState() =>
      _AdminDonationDetailsPageState();
}

class _AdminDonationDetailsPageState extends State<AdminDonationDetailsPage> {
  Map<String, dynamic>? donorData = {};

  @override
  void initState() {
    super.initState();
    getDonorData();
  }

  void getDonorData() async {
    Map<String, dynamic>? donor = await context
        .read<UserAuthProvider>()
        .getUserData(widget.donationData['donorId']);

    setState(() {
      donorData = donor;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Column(
                  children: [
                    const Text(
                      "Donation by:",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    donorData!['name'] == null
                        ? CircularProgressIndicator()
                        : Text(
                            "${donorData!['name']}",
                            style: const TextStyle(
                                fontSize: 35, color: Colors.white),
                          ),
                  ],
                )))),
        Padding(
            padding: const EdgeInsets.all(20),
            child: const Text("Donation Information",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline))),
        SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Category:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("${widget.donationData['category']}",
                            style: TextStyle(fontSize: 20))
                      ])),
              widget.donationData['category'] == 'Cash'
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Weight:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("${widget.donationData['weight']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ))
                          ])),
              widget.donationData['pickupOrDropoff'] == 'Pickup'
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Address:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("${widget.donationData['address']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ))
                          ]))
                  : Container(),
              widget.donationData['pickupOrDropoff'] == 'Pickup'
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Contact number:",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("${widget.donationData['contactNum']}",
                              style: const TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ))
                  : Container(),
              widget.donationData['pickupOrDropoff'] == 'Pickup'
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Pick up:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("${widget.donationData['pickUpDateTime']}",
                                style: const TextStyle(
                                  fontSize: 20,
                                )),
                          ]))
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Drop off:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("${widget.donationData['dropOffDateTime']}",
                                style: const TextStyle(fontSize: 20)),
                          ]))
            ],
          ),
        )
      ])),
    );
  }
}
