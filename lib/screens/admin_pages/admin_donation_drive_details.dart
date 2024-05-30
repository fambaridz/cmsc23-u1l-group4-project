import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDonationDriveDetailsPage extends StatefulWidget {
  final Map<String, dynamic> donationDriveData;
  const AdminDonationDriveDetailsPage(
      {super.key, required this.donationDriveData});

  @override
  State<AdminDonationDriveDetailsPage> createState() =>
      _AdminDonationDetailsPageState();
}

class _AdminDonationDetailsPageState
    extends State<AdminDonationDriveDetailsPage> {
  List<Map<String, dynamic>?> donDriveList = [];
  late List<Map<String, dynamic>> donationDataList = [];

  @override
  void initState() {
    super.initState();
    getDonationsData();
  }

  void getDonationsData() {
    List keys = widget.donationDriveData['donationList'].keys.toList();
    for (var key in keys) {
      String donationId = widget.donationDriveData['donationList'][key];
      context
          .read<DonationListProvider>()
          .getDonation(donationId)
          .then((value) {
        setState(() {
          donationDataList.add(value);
        });
      });
    }
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
                    Text(
                      "${widget.donationDriveData['name']}",
                      style: const TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ],
                )))),
        Padding(
            padding: const EdgeInsets.all(20),
            child: const Text("Donation Drive Information",
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
                        const Center(
                            child: Text("Status:",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold))),
                        widget.donationDriveData['status']
                            ? const Center(
                                child: Text("Open for donations",
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.green)))
                            : const Center(
                                child: Text("Closed for donations",
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.red))),
                        Center(
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Donations for ${widget.donationDriveData['name']}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                ))),
                        widget.donationDriveData.isEmpty
                            ? const Center(
                                child: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                        "No donations for this donation drive available.",
                                        style: TextStyle(fontSize: 19))),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, right: 17, top: 5, bottom: 10),
                                child: donationDataList.isEmpty
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        physics: const ScrollPhysics(
                                            parent:
                                                NeverScrollableScrollPhysics()),
                                        shrinkWrap: true,
                                        itemCount: widget
                                            .donationDriveData['donationList']
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                "${donationDataList[index]['category']} donation",
                                                style: TextStyle(fontSize: 23),
                                                textAlign: TextAlign.center,
                                              ));
                                        },
                                      )),
                      ])),
            ],
          ),
        )
      ])),
    );
  }
}

// donationDataList[index]['category']