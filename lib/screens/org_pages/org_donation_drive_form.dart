import 'package:cmsc23_project/components/textfield.dart';
import 'package:cmsc23_project/components/toggleswitch.dart';
import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:flutter/material.dart';

class DonationDriveForm extends StatefulWidget {
  final Organization organization;
  const DonationDriveForm(this.organization, {super.key});

  @override
  _DonationDriveFormState createState() => _DonationDriveFormState();
}

class _DonationDriveFormState extends State<DonationDriveForm> {
  @override
  Widget build(BuildContext context) {
    String name = '';
    bool status = true;
    String? orgId = widget.organization.id;
    List<String> donationList = [];

    final switchKey = GlobalKey<SwitchExampleState>();
    final txtForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Donation Drive'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Donation Drive Details",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.lightBlue[400],
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFieldSample(key: txtForm, (String val) {
            name = val;
          }, 'Name', 'Enter the name of the donation drive'),
          const SizedBox(height: 20),
          SwitchExample(
              key: switchKey,
              (bool val) {
                status = val;
              },
            ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // Add donation drive
              final donationDrive = DonationDrive(
                  id: '',
                  name: name,
                  status: status,
                  orgId: orgId!,
                  donationList: donationList);
              Navigator.pop(context, donationDrive);
            },
            child: Text('Finalize Donation Drive'),
          ),
        ],
      ),
    );
  }
}