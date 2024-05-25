import 'dart:io';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String userType = 'Donor';
  String? name, username, email, password, contactNum, aboutUs;
  Map<String, String> _addresses = {};
  File _itemPhoto = File('');
  String? errorMessage;
  bool isLoading = false;

  // Method that returns the title to be displayed depending
  // on the type of user that will sign up.
  Text _buildTitle() {
    switch (userType) {
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
    switch (userType) {
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
                  userType == 'Organization' ? descField : Container(),
                  addressField,
                  contactField,
                  itemPhoto,
                  if (errorMessage != null) signUpErrorMessage,
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
                  emailField,
                  passwordField,
                  addressField,
                  contactField,
                  if (errorMessage != null) signUpErrorMessage,
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
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [_buildTitle(), _buildContent(context)],
            )),
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
          child: userType == 'Donor'
              ? const Text("Your name",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ))
              : const Text("Organization's name",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  )),
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
          child: const Text("Choose a username",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              )),
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
        child: const Text("Email",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            )),
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
    ]),
  );

  Widget get passwordField => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.all(5.0),
        child: Text("Password",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      TextFormField(
        obscureText: true,
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

  Widget get descField => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("Organization description",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(
              width: 350,
              height: 150,
              child: TextFormField(
                maxLength: 150,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    hintText: "Short description of your organization.",
                    border: OutlineInputBorder(),
                    label: Text("Description"),
                    contentPadding: EdgeInsets.all(15)),
                onSaved: (value) => setState(() => aboutUs = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty.";
                  }
                  return null;
                },
              ))
        ]),
      );

  Widget get addressField => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.all(5.0),
        child: Text(
          "Enter your address/es",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          )
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: TextFormField(
          controller: _labelController,
          decoration: const InputDecoration(
            labelText: 'Label',
            hintText: 'Home, Office, School',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (_addresses.isEmpty) {
              return "Please enter a label for your address.";
            } else {
              return null;
            }
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Address',
            hintText: 'Street, Barangay, City, Province',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (_addresses.isEmpty) {
              return "Please enter an address.";
            } else {
              return null;
            }
          },
        ),
      ),
      Center(
        child: ElevatedButton(
          onPressed: () {
            // Check if both label and address are filled up
            if (_labelController.text.isNotEmpty &&
                _addressController.text.isNotEmpty) {
              _addresses[_labelController.text] = _addressController.text;
              setState(() {});
              _labelController.clear();
              _addressController.clear();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill up both fields.'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue[200]),
          child: const Text(
            'Add Address',
            style: TextStyle(
              fontSize: 15.0, 
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ),
      const SizedBox(height: 15),
      const Text(
        "Address/es",
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _addresses.length,
          itemBuilder: (context, index) {
            var label = _addresses.keys.toList();
            var address = _addresses.values.toList();
            return Padding(
              padding: const EdgeInsets.all(7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _addresses.remove(label[index]);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
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
      ),
    ])
  );

  Widget get contactField => Padding(
    padding: const EdgeInsets.only(top: 30, bottom: 30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: userType == 'Donor'
          ? const Text(
              "Your contact number",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            )
          : const Text(
              "Organization's contact number",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            )
      ),
      TextFormField(
        maxLength: 11,
        decoration: const InputDecoration(
          counterText: '',
          hintText: "09*********",
          border: OutlineInputBorder(),
          label: Text("Contact Number"),
        ),
        onSaved: (value) => setState(() => contactNum = value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Contact number cannot be empty.";
          } else {
            if (value.length != 11) {
              return "Invalid contact number.";
            }
          }
          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
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
        onPressed: isLoading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  if (userType == 'Donor') {
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

                    final result = await context
                        .read<UserAuthProvider>()
                        .authService
                        .signUpDonor(userType, name!, username!, email!, password!, _addresses, contactNum!);

                    setState(() {
                      isLoading = false;
                    });

                    if (result == null) {
                      setState(() {
                        errorMessage = "Unknown error occurred.";
                      });
                    } else if (result['userType'] == "Donor") {
                      setState(() {
                        errorMessage = null;
                      });
                      Navigator.pushNamed(context, "/donor-home",
                          arguments: result);
                    } else {
                      setState(() {
                        errorMessage = result["error"];
                      });
                    }
                  // if user is not a donor, check first if proof was uploaded
                  } else if (_itemPhoto.path.isNotEmpty) {
              
                    _formKey.currentState?.save();

                    setState(() {
                      isLoading = true;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signing up...'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    final result = await context
                        .read<UserAuthProvider>()
                        .authService
                        .signUpOrg(userType, name!, aboutUs!, username!, email!, password!, _addresses, contactNum!);

                    setState(() {
                      isLoading = false;
                    });

                    if (result == null) {
                      setState(() {
                        errorMessage = "Unknown error occurred.";
                      });
                    } else if (result['userType'] == "Organization") {
                      setState(() {
                        errorMessage = null;
                      });
                      Navigator.pushNamed(context, "/org-home");
                    } else {
                      setState(() {
                        errorMessage = result["error"];
                      });
                    }
                  }
                }
              },
        child: isLoading
          ? CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.lightBlue[400],
            )
          : Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
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
            _labelController.clear();
            _addressController.clear();
            _addresses.clear();
            userType = 'Organization';
          });
        },
      )
    ])
  );

  Widget get itemPhoto => Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Photo of Proof of Legitimacy",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: _itemPhoto.path.isEmpty
                ? Center(
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: _takePhoto,
                    ),
                  )
                : Image.file(_itemPhoto, fit: BoxFit.cover),
          ),
        ],
      ),
    );

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _itemPhoto = File(pickedFile.path);
      });
    }
  }
}
