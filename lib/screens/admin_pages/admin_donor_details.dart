import 'package:flutter/material.dart';

class AdminDonorDetailsPage extends StatelessWidget {
  final Map<String, dynamic>? donor;
  const AdminDonorDetailsPage({super.key, this.donor});

  @override
  Widget build(BuildContext context) {
    List<String> label = donor!['addresses'].keys.toList();
    List<String> address = donor!['addresses'].value.toList();

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
                      donor!['name'],
                      style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      donor!['username'],
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
                          Text("Contact Number: ${donor!['contactNum']}",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                          const Text("Address/es:",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: donor!['addresses'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(7),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "${label[index]}: ",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "${address[index]}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ))),
          ],
        ),
      ),
    );
  }
}
