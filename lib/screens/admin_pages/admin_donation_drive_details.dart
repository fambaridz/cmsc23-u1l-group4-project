import 'package:flutter/material.dart';

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
        // Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: const Text("Donation Information",
        //         style: TextStyle(
        //             fontSize: 25,
        //             fontWeight: FontWeight.bold,
        //             decoration: TextDecoration.underline))),
        // SizedBox(
        //   width: 350,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Padding(
        //           padding: const EdgeInsets.all(10),
        //           child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const Text("Category:",
        //                     style: TextStyle(
        //                         fontSize: 20, fontWeight: FontWeight.bold)),
        //                 Text("${widget.donationDriveData['category']}",
        //                     style: TextStyle(fontSize: 20))
        //               ])),
        //       widget.donationDriveData['category'] == 'Cash'
        //           ? Container()
        //           : Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     const Text("Weight:",
        //                         style: TextStyle(
        //                             fontSize: 20, fontWeight: FontWeight.bold)),
        //                     Text("${widget.donationDriveData['weight']}",
        //                         style: const TextStyle(
        //                           fontSize: 20,
        //                         ))
        //                   ])),
        //       widget.donationDriveData['pickupOrDropoff'] == 'Pickup'
        //           ? Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     const Text("Address:",
        //                         style: TextStyle(
        //                             fontSize: 20, fontWeight: FontWeight.bold)),
        //                     Text("${widget.donationDriveData['address']}",
        //                         style: const TextStyle(
        //                           fontSize: 20,
        //                         ))
        //                   ]))
        //           : Container(),
        //       widget.donationDriveData['pickupOrDropoff'] == 'Pickup'
        //           ? Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   const Text("Contact number:",
        //                       style: TextStyle(
        //                           fontSize: 20, fontWeight: FontWeight.bold)),
        //                   Text("${widget.donationDriveData['contactNum']}",
        //                       style: const TextStyle(
        //                         fontSize: 20,
        //                       )),
        //                 ],
        //               ))
        //           : Container(),
        //       widget.donationDriveData['pickupOrDropoff'] == 'Pickup'
        //           ? Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     const Text("Pick up:",
        //                         style: TextStyle(
        //                             fontSize: 20, fontWeight: FontWeight.bold)),
        //                     Text(
        //                         "${widget.donationDriveData['pickUpDateTime']}",
        //                         style: const TextStyle(
        //                           fontSize: 20,
        //                         )),
        //                   ]))
        //           : Padding(
        //               padding: const EdgeInsets.all(10),
        //               child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     const Text("Drop off:",
        //                         style: TextStyle(
        //                             fontSize: 20, fontWeight: FontWeight.bold)),
        //                     Text(
        //                         "${widget.donationDriveData['dropOffDateTime']}",
        //                         style: const TextStyle(fontSize: 20)),
        //                   ]))
        //     ],
        //   ),
        // )
      ])),
    );
  }
}
