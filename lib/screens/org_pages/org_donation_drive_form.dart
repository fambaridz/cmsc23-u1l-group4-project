import 'package:cmsc23_project/components/textfield.dart';
import 'package:cmsc23_project/components/toggleswitch.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/providers/donation_drive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveForm extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DonationDriveForm({super.key, required this.userData});

  @override
  _DonationDriveFormState createState() => _DonationDriveFormState();
}

class _DonationDriveFormState extends State<DonationDriveForm> {
  String name = '';
  bool status = false;
  final switchKey = GlobalKey<SwitchExampleState>();
  final txtForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create a Donation Drive'),
        ),
        body: Form(
          key: txtForm,
          child: Column(
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
              TextFieldSample((String val) {
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
                onPressed: () async {
                  if (!txtForm.currentState!.validate()) {
                    return;
                  }
                  final donationDrive = DonationDrive(
                      name: name,
                      status: status,
                      orgId: widget.userData['id'],
                      donationList: {});

                  String message = await context
                      .read<DonationDriveProvider>()
                      .addDonationDrive(donationDrive);

                  if (!message.startsWith("Error in")) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.lightBlue[400],
                        content: const Text(
                          'Donation drive created successfully!',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        duration: const Duration(seconds: 5),
                      ),
                    );

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text(
                          'Failed to create donation drive! Please try again.',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                },
                child: Text(
                  'Finalize Donation Drive',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[200],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
