import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDonorDetailsPage extends StatefulWidget {
  final Map<String, dynamic> donorData;
  const AdminDonorDetailsPage({super.key, required this.donorData});

  @override
  State<AdminDonorDetailsPage> createState() => _AdminDonorDetailsPageState();
}

class _AdminDonorDetailsPageState extends State<AdminDonorDetailsPage> {
  late List<Map<String, dynamic>?> donationList = [];

  @override
  void initState() {
    super.initState();
    getDonorDonations();
  }

  void getDonorDonations() async {
    List<Map<String, dynamic>?> donations = await context
        .read<DonationListProvider>()
        .getDonationByUserId(widget.donorData['id']);
    setState(() {
      donationList = donations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About ${widget.donorData['name']}"),
      ),
      body: Center(
        child: ListView(
          children: [
            Row(children: [
              Expanded(
                  child: Container(
                      width: double.infinity,
                      color: Colors.lightBlue[200],
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                widget.donorData['name'],
                                style: const TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text('@${widget.donorData['username']}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic)),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 20),
                              child: SizedBox(
                                width: 350,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, bottom: 5),
                                        child: Text("Contact Number: ",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))),
                                    Text("${widget.donorData['contactNum']}",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        child: Text("Address/es: ",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))),
                                    ListView.builder(
                                      physics: ScrollPhysics(
                                          parent:
                                              NeverScrollableScrollPhysics()),
                                      shrinkWrap: true,
                                      itemCount:
                                          widget.donorData['addresses'].length,
                                      itemBuilder: (context, index) {
                                        var label = widget
                                            .donorData['addresses'].keys
                                            .toList();
                                        var address = widget
                                            .donorData['addresses'].values
                                            .toList();
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 7),
                                          child: RichText(
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "${label[index]}: ",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "${address[index]}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )))
            ]),
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text("Donations by ${widget.donorData['name']}",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)))),
            ListView.builder(
                physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                shrinkWrap: true,
                itemCount: donationList.length,
                itemBuilder: (context, index) {
                  var donation = donationList[index];

                  return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(children: [
                        Text(
                          '${donation!['category']} donation',
                          style: const TextStyle(fontSize: 20),
                        ),
                        donation['pickupOrDropoff'] == 'Pickup'
                            ? Text('Picked up on ${donation['pickUpDateTime']}')
                            : Text(
                                'Dropped off on ${donation['dropOffDateTime']}')
                      ]));
                }),
          ],
        ),
      ),
    );
  }
}
