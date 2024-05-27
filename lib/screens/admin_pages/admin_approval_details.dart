import 'package:flutter/material.dart';

class AdminApprovalDetailsPage extends StatelessWidget {
  final Map<String, dynamic> orgData;
  const AdminApprovalDetailsPage({super.key, required this.orgData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization Application"),
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
                              text: orgData['name'],
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                                text: '\n\n@${orgData['username']}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white))
                          ]))))),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("About Us:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(orgData['aboutUs'],
                          style: const TextStyle(fontSize: 19))),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Status:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  orgData['status']
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
                      child: Text(orgData['email'],
                          style: const TextStyle(fontSize: 19))),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Contact Number:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(orgData['contactNum'],
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
                        itemCount: orgData['addresses'].length,
                        itemBuilder: (context, index) {
                          var label = orgData['addresses'].keys.toList();
                          var address = orgData['addresses'].values.toList();
                          return Padding(
                            padding: const EdgeInsets.all(7),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                textAlign: TextAlign.justify,
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
                    child: orgData['photoUrl'] != null
                        ? Image.network('${orgData['photoUrl']}',
                            width: 400, height: 400)
                        : const Text('No photo uploaded.',
                            style: TextStyle(
                                fontSize: 19, fontStyle: FontStyle.italic)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 60),
                      child: Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue[400]),
                            onPressed: () {},
                            child: const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Approve Organization\nApplication',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ))),
                      )),
                ],
              ))),
        ],
      )),
    );
  }
}
