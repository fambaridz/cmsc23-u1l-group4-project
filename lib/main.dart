import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:cmsc23_project/screens/admin_home.dart';
import 'package:cmsc23_project/screens/sign_up.dart';

import '../screens/donor_home.dart';
import '../screens/landing.dart';
import 'package:cmsc23_project/screens/org_donation.dart';
import 'package:cmsc23_project/screens/org_donation_details.dart';
import 'package:cmsc23_project/screens/org_donation_drive.dart';
import 'package:cmsc23_project/screens/org_profile.dart';
import 'package:cmsc23_project/screens/organization_home.dart';
import '../screens/sign_in.dart';
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
        "/sign-up": (context) => const SignUpPage(),
        "/donor-home": (context) => const DonorHomePage(),
        "/org-home": (context) => const OrganizationHomePage(),
        "/org-home/donation": (context) => const OrganizationDonationPage(),
        "/org-home/donation/details": (context) => OrganizationDonationDetails(
            ModalRoute.of(context)!.settings.arguments as Map<String, Donation>),
        "/org-home/profile": (context) => OrganizationDetails(
            ModalRoute.of(context)!.settings.arguments as Map<String, Organization>),
        "/org-home/donation-drive": (context) => const OrganizationDonationDrivePage(),
        "/admin-home": (context) => const AdminHome(),
      },
    ),
  );
}
