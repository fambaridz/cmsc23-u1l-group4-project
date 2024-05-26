import 'package:flutter/material.dart';
import 'package:cmsc23_project/screens/donor_pages/donor_drawer.dart';

class DonorDonationList extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DonorDonationList({super.key, required this.userData});

  @override
  State<DonorDonationList> createState() => _DonorDonationListState();
}

class _DonorDonationListState extends State<DonorDonationList> {
  final List<String> donations = [
    'Donation 1',
    'Donation 2',
    'Donation 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DonorDrawer(userData: widget.userData),
      appBar: AppBar(
        title: Text("Donations"),
      ),
      body: Center(
        child: donations.isEmpty
            ? const Text("No donations available")
            : ListView(
                padding: const EdgeInsets.all(10),
                children: donations
                    .map((donation) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/donor-donation-details");
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
                                donation,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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