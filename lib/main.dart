import 'package:cmsc23_project/model/donation.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/model/organization.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/screens/admin_home.dart';
import 'package:cmsc23_project/screens/donor_donation.dart';
import 'package:cmsc23_project/screens/donor_home.dart';
import 'package:cmsc23_project/screens/donor_org_details.dart';
import 'package:cmsc23_project/screens/donor_profile.dart';
import 'package:cmsc23_project/screens/landing.dart';
import 'package:cmsc23_project/screens/org_donation_drive_details.dart';
import 'package:cmsc23_project/screens/org_donation_drive_form.dart';
import 'package:cmsc23_project/screens/sign_in.dart';
import 'package:cmsc23_project/screens/sign_up.dart';
import 'package:cmsc23_project/screens/org_donation_details.dart';
import 'package:cmsc23_project/screens/org_donation_drive.dart';
import 'package:cmsc23_project/screens/org_profile.dart';
import 'package:cmsc23_project/screens/org_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => UserAuthProvider()))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        // donor routes
        "/donor-home": (context) => DonorHomePage(userData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        "/donor-profile": (context) => DonorProfile(userData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        "/donor-org-details": (context) => DonorOrgDetailsPage(),
        "/donor-donation": (context) => const DonorDonationPage(),
        // organization routes
        "/org-home": (context) => const OrganizationHomePage(),
        "/org-home/donation/details": (context) => OrganizationDonationDetails(
          ModalRoute.of(context)!.settings.arguments as Map<String, Donation>),
        "/org-home/profile": (context) => OrganizationDetails(
          ModalRoute.of(context)!.settings.arguments as Map<String, Organization>),
        "/org-home/donation-drive": (context) => const OrganizationDonationDrivePage(),
        "/org-home/donation-drive/details": (context) => OrganizationDonationDriveDetails(
          ModalRoute.of(context)!.settings.arguments as Map<String, DonationDrive>),
        "/org-home/donation-drive/add": (context) => DonationDriveForm(
            ModalRoute.of(context)!.settings.arguments as Organization),
      },
    );
  }
}