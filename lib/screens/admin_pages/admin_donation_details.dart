import 'package:flutter/material.dart';

class AdminDonationDetailsPage extends StatelessWidget {
  final Map<String, dynamic>? donation;
  final String? donorName;
  const AdminDonationDetailsPage({super.key, this.donation, this.donorName});

  @override
  Widget build(BuildContext context) {
    Map<int, String> status = {
      1: "Pending",
      2: "Confirmed",
      3: "For Pick-up",
      4: "Completed",
      5: "Cancelled"
    };

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
                  "$donorName",
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
              Text("${donation!['category']}", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Weight:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation!['weight']}",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              Text("Address:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation!['address']}",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              Text("Donor's contact number:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${donation!['contactNum']}",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 10),
              donation!['pickUpDateTime'] != null
                  ? Row(children: [
                      Text("Pick up: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("${donation!['pickUpDateTime']}",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ])
                  : Container(),
              SizedBox(height: 10),
              donation!['dropOffDateTime'] != null
                  ? Row(children: [
                      Text("Drop off:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("${donation!['dropOffDateTime']}",
                          style: TextStyle(fontSize: 20)),
                    ])
                  : Container(),
              donation!['itemPhoto'] != null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.network(donation!['itemPhoto'],
                          fit: BoxFit.cover),
                    )
                  : Container(),
              SizedBox(height: 10),
              Text("Donation status:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${status[donation!['status']]}",
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ],
          ),
        )
      ])),
    );
  }
}
