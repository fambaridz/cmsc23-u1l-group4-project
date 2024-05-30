import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:flutter/material.dart';

class OrganizationDetails extends StatelessWidget {
  final Map<String, dynamic> userData;
  const OrganizationDetails({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final List<DonationDrive> donationDriveList = [
      
    ];
    // var details = info["details"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userData['name'],
        ),
      ),
      body: Center(
        child: Column(
        children: [
          Container(
              constraints: const BoxConstraints(minHeight: 150, maxHeight: 200),
              width: double.infinity,
              color: Colors.lightBlue[200],
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: userData['name'],
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                                text: '\n\n@${userData['username']}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ]))))),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("About Us:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(userData['aboutUs'],
                          style: const TextStyle(fontSize: 19))),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Status for Donations:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  userData['status']
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Open",
                            style: TextStyle(fontSize: 19),
                          ))
                      : const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Closed",
                            style: TextStyle(fontSize: 19),
                          )),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Email:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(userData['email'],
                          style: const TextStyle(fontSize: 19))),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Contact Number:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(userData['contactNum'],
                          style: const TextStyle(fontSize: 19))),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Address/es:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 17, right: 17, top: 5, bottom: 10),
                      child: ListView.builder(
                        physics: const ScrollPhysics(
                            parent: NeverScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: userData['addresses'].length,
                        itemBuilder: (context, index) {
                          var label = userData['addresses'].keys.toList();
                          var address = userData['addresses'].values.toList();
                          return Padding(
                            padding: const EdgeInsets.all(7),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${label[index]}: ",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue[400],
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${address[index]}",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Proof of Legitimacy",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: userData['photoUrl'] != null
                        ? Image.network('${userData['photoUrl']}',
                            width: 400, height: 400)
                        : const Text('No photo uploaded.',
                            style: TextStyle(
                                fontSize: 19, fontStyle: FontStyle.italic)),
                  ),
                  SizedBox(height: 20),
                ],
              ))),
        ],
      )),
    );
  }
}

