import 'package:cmsc23_project/screens/donor_home.dart';
import 'package:cmsc23_project/screens/landing.dart';
import 'package:cmsc23_project/screens/sign_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.lightBlue[200],
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 239, 240, 243),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const LandingPage(),
        "/sign-in": (context) => const SignInPage(),
        "/donor-home": (context) => const DonorHomePage(),
      },
    ),
  );
}