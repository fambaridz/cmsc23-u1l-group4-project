import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? userType, name, username, password, contact;
  List<String?> address = [];

  // Method that returns the title to be displayed depending
  // on the type of user that will sign up.
  Text _buildTitle() {
    switch (userType) {
      case 'organization':
        return const Text("Sign Up as an Organization");
      default:
        return const Text("Sign Up as a Donor");
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
                  fileUpload
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
                  orgSignUp
                ],
              ));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildTitle(), _buildContent(context)],
        ),
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

  Widget get orgSignUp => Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(children: [
        Text('Not a donor?'),
        TextButton(
          child: Text('Sign up as an organization'),
          onPressed: () {
            setState(() {
              userType = 'organization';
            });
          },
        )
      ]));

  Widget get fileUpload => Column(children: [
        Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Please submit any proof of your organization's legitimacy.\nFile must be in pdf, jpg, or jpeg only.",
            )),
        ElevatedButton(
          child: Text('Choose files'),
          onPressed: () async {
            final fileResult = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.custom,
                allowedExtensions: ['pdf', 'jpg', 'jpeg']);
            if (fileResult == null) return;
          },
        )
      ]);
}
