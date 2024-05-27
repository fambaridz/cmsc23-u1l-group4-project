import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? errorMessage;
  bool isLoading = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                heading,
                const SizedBox(height: 70),
                emailField,
                const SizedBox(height: 20),
                passwordField,
                const SizedBox(height: 20),
                if (errorMessage != null) signInErrorMessage,
                submitButton,
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget get heading => Text(
    "Sign In",
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.lightBlue[400],
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
  );

  Widget get emailField => TextFormField(
    decoration: InputDecoration(
      labelText: "Email",
      border: OutlineInputBorder(),
    ),
    onSaved: (value) => setState(() => email = value),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your email";
      }
      return null;
    },
  );

  Widget get passwordField => TextFormField(
    obscureText: !_passwordVisible,
    enableSuggestions: false,
    autocorrect: false,
    decoration: InputDecoration(
        labelText: "Password",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            })),
    onSaved: (value) => setState(() => password = value),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your password";
      }
      return null;
    },
  );

  Widget get signInErrorMessage => errorMessage != null
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

  Widget get submitButton => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlue[200],
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: isLoading ? null : () async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        setState(() {
          isLoading = true;
        });

        final result = await context
          .read<UserAuthProvider>()
          .authService
          .signIn(email!, password!);
          
        setState(() {
          isLoading = false;
        });

        if (result == null) {
          setState(() {
            errorMessage = "Unknown error occurred.";
          });
        } else if (result['userType'] == "Admin" || result['userType'] == "Donor" || result['userType'] == "Organization") {
          setState(() {
            errorMessage = null;
          });
          
          if (result['userType'] == "Admin") {
            Navigator.pushNamed(context, "/admin-home");
          } else if (result['userType'] == "Donor") {
            Navigator.pushNamed(context, "/donor-home");
          } else if (result['userType'] == "Organization") {
            Navigator.pushNamed(context, "/org-home");
          }
        } else {
          setState(() {
            errorMessage = result["error"];
          });
        }
      }
    },
    child: isLoading
      ? CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.lightBlue[400],
      ) 
      : Text(
      "Sign In",
      style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
