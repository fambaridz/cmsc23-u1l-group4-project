import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? userType = 'donor', name, username, password, contact;
  List<String?> address = [];
  final _formKey = GlobalKey<FormState>();
  bool filesUploaded = false;

  // Method that returns the title to be displayed depending
  // on the type of user that will sign up.
  Text _buildTitle() {
    switch (userType) {
      case 'organization':
        return const Text(
          "Sign Up as an Organization",
          style: TextStyle(fontSize: 25.0),
        );
      default:
        return const Text(
          "Sign Up as a Donor",
          style: TextStyle(fontSize: 25.0),
        );
    }
  }

  // Method that returns the main content of the page to be displayed depending
  // on the type of user that will sign up.
  Widget _buildContent(BuildContext context) {
    switch (userType) {
      case 'organization':
        {
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  nameField,
                  usernameField,
                  passwordField,
                  addressField,
                  contactField,
                  fileUpload,
                  submitButton
                ],
              ));
        }
      default:
        {
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  nameField,
                  usernameField,
                  passwordField,
                  addressField,
                  contactField,
                  submitButton,
                  orgSignUp
                ],
              ));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buildTitle(), _buildContent(context)],
                )),
          ),
        ]));
  }

  Widget get nameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Name"),
          ),
          onSaved: (value) => setState(() => name = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Name cannot be empty.";
            }
            return null;
          },
        ),
      );

  Widget get usernameField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Username"),
          ),
          onSaved: (value) => setState(() => username = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Username cannot be empty.";
            }
            return null;
          },
        ),
      );

  Widget get addressField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Address"),
          ),
          onSaved: (value) => setState(() => address[address.length] = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Address cannot be empty.";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Password"),
          ),
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Password cannot be empty.";
            }
            return null;
          },
        ),
      );

  Widget get contactField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Contact Number"),
          ),
          onSaved: (value) => setState(() => contact = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Contact number cannot be empty.";
            }
            return null;
          },
        ),
      );

  Widget get submitButton => Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue[400]),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (userType == 'donor') {
                _formKey.currentState?.save();
              } else if (filesUploaded == true) {
                // if user is not a donor, check first if proof was uploaded
                _formKey.currentState?.save();
              }
            }
          },
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          )));

  Widget get orgSignUp => Padding(
      padding: const EdgeInsets.all(30),
      child: Column(children: [
        const Text(
          'Not a donor?',
          style: TextStyle(fontSize: 18.0),
        ),
        TextButton(
          child: Text(
            'Sign up as an organization',
            style: TextStyle(fontSize: 18.0, color: Colors.lightBlue[400]),
          ),
          onPressed: () {
            setState(() {
              userType = 'organization';
            });
          },
        )
      ]));

  Widget get fileUpload => Column(children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.8, color: Colors.black)),
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                const Text(
                  "Please submit any proof of your organization's legitimacy.",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "File must be in pdf, jpg, or jpeg format only.",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[400]),
                      child: const Text(
                        'Choose files',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        final fileResult = await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'jpg', 'jpeg']);
                        if (fileResult == null) {
                          return;
                        } else {
                          filesUploaded = true;
                        }
                      },
                    ))
              ])),
        ),
      ]);
}
