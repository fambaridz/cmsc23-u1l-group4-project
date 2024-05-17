import 'package:cmsc23_project/components/textfield.dart';
import 'package:cmsc23_project/components/toggleswitch.dart';
import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:flutter/material.dart';

class DonationDriveForm extends StatefulWidget {
  final Organization organization;
  const DonationDriveForm(this.organization,{super.key});
  @override
  _DonationDriveFormState createState() => _DonationDriveFormState();
}

class _DonationDriveFormState extends State<DonationDriveForm> {
  
  @override
  Widget build(BuildContext context) {
    String name = '';
    bool status = true;
    Organization organization = widget.organization;
    List<Donation> donationList = [];

    final switchKey = GlobalKey<SwitchExampleState>();
    final txtForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Donation Drive'),
      ),
      body: Column(
        children: [
          TextFieldSample(key: txtForm, (String val) {
            name = val;
          }, 'Name', 'Enter the name of the donation drive'),
          SwitchExample(key: switchKey, (bool val) {
                      status = val;
                  }),
          
          ElevatedButton(
            onPressed: () {
              // Add donation drive
              final donationDrive = DonationDrive(
                id: '',
                name: name,
                status: status,
                organization: organization,
                donationList: donationList
              );
              Navigator.pop(context, donationDrive);
            },
            child: Text('Add Donation Drive'),
          ),
        ],
      ),
    );
  }
}