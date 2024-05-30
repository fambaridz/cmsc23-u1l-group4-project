import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/donation_drive_provider.dart';

class AdminOrgDetailsPage extends StatefulWidget {
  final Map<String, dynamic> orgData;
  const AdminOrgDetailsPage({super.key, required this.orgData});

  @override
  State<AdminOrgDetailsPage> createState() => _AdminOrgDetailsPageState();
}

class _AdminOrgDetailsPageState extends State<AdminOrgDetailsPage> {
  List<Map<String, dynamic>?> donDriveList = [];

  @override
  void initState() {
    super.initState();
    getDonationDrives();
  }

  void getDonationDrives() async {
    List<Map<String, dynamic>?> dDrives = await context
        .read<DonationDriveProvider>()
        .getDonationDriveByOrgId(widget.orgData['id']);

    if (dDrives[0] != null) {
      setState(() {
        donDriveList = dDrives;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization"),
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
                              text: widget.orgData['name'],
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                                text: '\n\n@${widget.orgData['username']}',
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
                      child: Text(widget.orgData['aboutUs'],
                          style: const TextStyle(fontSize: 19))),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Status:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  widget.orgData['status']
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
                      child: Text(widget.orgData['email'],
                          style: const TextStyle(fontSize: 19))),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Contact Number:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(widget.orgData['contactNum'],
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
                        itemCount: widget.orgData['addresses'].length,
                        itemBuilder: (context, index) {
                          var label = widget.orgData['addresses'].keys.toList();
                          var address =
                              widget.orgData['addresses'].values.toList();
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
                    child: widget.orgData['photoUrl'] != null
                        ? Image.network('${widget.orgData['photoUrl']}',
                            width: 400, height: 400)
                        : const Text('No photo uploaded.',
                            style: TextStyle(
                                fontSize: 19, fontStyle: FontStyle.italic)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Donation drives:",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold)),
                  ),
                  donDriveList.isEmpty
                      ? const Center(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("No donation drives available.",
                                  style: TextStyle(fontSize: 19))),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 17, right: 17, top: 5, bottom: 10),
                          child: ListView.builder(
                            physics: const ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: donDriveList.length,
                            itemBuilder: (context, index) {
                              var donationDrive = donDriveList[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/admin/donationdrive-info",
                                        arguments: donationDrive);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[100],
                                      ),
                                      margin: EdgeInsets.all(10),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(20),
                                        title: RichText(
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${donationDrive!['name']}",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.lightBlue[400],
                                                ),
                                              ),
                                              TextSpan(
                                                text: "\nStatus: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              donationDrive['status']
                                                  ? TextSpan(
                                                      text: "Open",
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.green,
                                                      ),
                                                    )
                                                  : TextSpan(
                                                      text: "Closed",
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      )));
                            },
                          )),
                ],
              ))),
        ],
      )),
    );
  }
}
