import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String user_type = 'Donor';
  String? name, username, email, password, address, contact_num;
  // List<String?> address = [];
  bool filesUploaded = false;
  String? errorMessage;
  bool isLoading = false;

  // Method that returns the title to be displayed depending
  // on the type of user that will sign up.
  Text _buildTitle() {
    switch (user_type) {
      case 'Organization':
        return Text(
          "Sign Up as an Organization",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.lightBlue[400],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        );
      default:
        return Text(
          "Sign up as a Donor",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.lightBlue[400],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        );
    }
  }

  // Method that returns the main content of the page to be displayed depending
  // on the type of user that will sign up.
  Widget _buildContent(BuildContext context) {
    switch (user_type) {
      case 'Organization':
        {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                nameField,
                usernameField,
                emailField,
                passwordField,
                addressField,
                contactField,
                fileUpload,
                submitButton
              ],
            )
          );
        }
      default:
        {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                nameField,
                usernameField,
                emailField,
                passwordField,
                addressField,
                contactField,
                if (errorMessage != null) signUpErrorMessage,
                submitButton,
                orgSignUp
              ],
            )
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [_buildTitle(), _buildContent(context)],
          )
        ),
      ),
    ]));
  }

  Widget get nameField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: user_type == 'Donor'
            ? const Text(
                "Your name",
                style: TextStyle(fontSize: 16.0),
              )
            : const Text("Name of organization",
                style: TextStyle(fontSize: 16.0)),
        ),
        TextFormField(
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
        )
      ],
    )
  );

  Widget get usernameField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text("Choose a username", style: TextStyle(fontSize: 16.0)),
        ),
        TextFormField(
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
        )
      ],
    )
  );

  Widget get emailField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Text("Choose an email", style: TextStyle(fontSize: 16.0)),
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
          ),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email cannot be empty.";
            }
            return null;
          },
        )
      ]
    ),
  );

  Widget get passwordField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.all(5.0),
        child: Text("Choose a password", style: TextStyle(fontSize: 16.0)),
      ),
      TextFormField(
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
      )
    ]),
  );

  Widget get addressField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: user_type == 'Donor'
          ? const Text(
              "Your address",
              style: TextStyle(fontSize: 16.0),
            )
          : const Text("Organization's address/es",
              style: TextStyle(fontSize: 16.0)),
      ),
      TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Address"),
        ),
        onSaved: (value) => setState(() => address = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Address cannot be empty.";
          }
          return null;
        },
      ),
    ])
  );

  Widget get contactField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: user_type == 'Donor'
          ? const Text(
              "Your contact number",
              style: TextStyle(fontSize: 16.0),
            )
          : const Text("Organization's contact number",
              style: TextStyle(fontSize: 16.0)),
      ),
      TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Contact Number"),
        ),
        onSaved: (value) => setState(() => contact_num = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Contact number cannot be empty.";
          }
          return null;
        },
      ),
    ])
  );

  Widget get signUpErrorMessage => errorMessage != null
    ? Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Text(
          errorMessage!,
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      )
    : Container();

  Widget get submitButton => Padding(
    padding: const EdgeInsets.all(12),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue[400],
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: isLoading ? null : () async {
          if (_formKey.currentState!.validate()) {
            if (user_type == 'Donor') {
              
              _formKey.currentState?.save();

              setState(() {
                isLoading = true;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signing up...'),
                  duration: Duration(seconds: 2),
                ),
              );

              String? resp = await context
                .read<UserAuthProvider>()
                .authService
                .signUpDonor(user_type!, name!, username!, email!, password!, address!, contact_num!);
              
              if (resp != null) {
                setState(() {
                  errorMessage = resp;
                  isLoading = false;
                });
              } else {
                Navigator.pushNamed(context, "/donor-home");
              }
              
            } else if (filesUploaded == true) {
              // if user is not a donor, check first if proof was uploaded
              _formKey.currentState?.save();
              Navigator.pushNamed(context, "/sign-in");
            }
          }
        },
        child: isLoading
          ? CircularProgressIndicator(
              strokeWidth: 1,
          ) 
          : Text(
          'Sign Up',
          style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
        )
    )
  );

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
            _formKey.currentState?.reset();
            user_type = 'Organization';
          });
        },
      )
    ])
  );

  Widget get fileUpload => Column(children: [
    SizedBox(height: 20.0),
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
                fontSize: 13.0,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
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
                      setState(() {
                        filesUploaded = true;
                      });
                    }
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: filesUploaded
                  ? const Text(
                      "Files have been uploaded successfully.",
                      style: TextStyle(color: Colors.green),
                    )
                  : const Text(
                      "No files have been uploaded yet.",
                      style: TextStyle(color: Colors.redAccent),
                    ),
            ),
          ])),
    ),
    SizedBox(height: 20.0)
  ]);
}
