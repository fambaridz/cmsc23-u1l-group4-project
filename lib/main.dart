import '../screens/admin_pages/admin_org_details.dart';
import '../screens/admin_pages/admin_profile.dart';
import '../model/donation.dart';
import '../model/organization.dart';
import 'screens/admin_pages/admin_approval_details.dart';
import 'screens/admin_pages/admin_donation_details.dart';
import 'screens/admin_pages/admin_donor_details.dart';
import 'screens/admin_pages/admin_home.dart';
import '../screens/donor_donation.dart';
import '../screens/donor_home.dart';
import '../screens/donor_profile.dart';
import '../screens/landing.dart';
import '../screens/sign_in.dart';
import '../screens/sign_up.dart';
import '../screens/org_donation.dart';
import '../screens/org_donation_details.dart';
import '../screens/org_donation_drive.dart';
import '../screens/org_profile.dart';
import '../screens/organization_home.dart';
import 'screens/admin_pages/admin_approvals.dart';
import 'screens/admin_pages/admin_organizations.dart';
import 'screens/admin_pages/admin_donors.dart';
import 'screens/admin_pages/admin_donations.dart';
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
        // admin routes
        "/admin-home": (context) => const AdminHome(),
        "/admin-profile": (context) => const AdminProfile(),
        "/admin/organizations": (context) => const AdminOrganizationsPage(),
        "/admin/donations": (context) => const AdminDonationsPage(),
        "/admin/donors": (context) => const AdminDonorsPage(),
        "/admin/approvals": (context) => const AdminApprovalsPage(),
        "/admin/organization-info": (context) => AdminOrgDetailsPage(),
        "/admin/donation-info": (context) => const AdminDonationDetailsPage(),
        "/admin/donor-info": (context) => const AdminDonorDetailsPage(),
        "/admin/approval-info": (context) => const AdminApprovalDetailsPage(),
        // donor routes
        "/donor-home": (context) => const DonorHomePage(),
        "/donor-profile": (context) => const DonorProfile(),
        "/donor-donation": (context) => const DonorDonationPage(),
        // organization routes
        "/org-home": (context) => const OrganizationHomePage(),
        "/org-home/donation": (context) => const OrganizationDonationPage(),
        "/org-home/donation/details": (context) => OrganizationDonationDetails(
            ModalRoute.of(context)!.settings.arguments
                as Map<String, Donation>),
        "/org-home/profile": (context) => OrganizationDetails(
            ModalRoute.of(context)!.settings.arguments
                as Map<String, Organization>),
        "/org-home/donation-drive": (context) =>
            const OrganizationDonationDrivePage(),
      },
    ),
  );
}
