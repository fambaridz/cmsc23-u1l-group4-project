import 'package:cmsc23_project/screens/donor_drawer.dart';
import 'package:flutter/material.dart';

class DonorHomePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DonorHomePage({super.key, required this.userData});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final List<String> organizations = [
    'Organization A',
    'Organization B',
    'Organization C',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DonorDrawer(userData: widget.userData),
      appBar: AppBar(
        title: Text("Donor Home"),
      ),
      body: Center(
        child: organizations.isEmpty
            ? const Text("No organizations available")
            : ListView(
                padding: const EdgeInsets.all(10),
                children: organizations
                    .map((organization) => GestureDetector(
                          onTap: () {
                            print(widget.userData);
                            Navigator.pushNamed(context, "/donor-org-details");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                organization,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/donor-donation",
                                      arguments: widget.userData);
                                },
                                child: Text(
                                  "Donate",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
