import 'package:cmsc23_project/GlobalContextService.dart';
import 'package:cmsc23_project/model/donation_drive.dart';
import 'package:cmsc23_project/providers/donation_drive_provider.dart';
import 'package:cmsc23_project/providers/donation_drive_provider.dart';
import 'package:cmsc23_project/providers/donation_provider.dart';
import 'package:cmsc23_project/screens/donor_pages/donor_donation_list.dart';
import 'package:cmsc23_project/screens/org_pages/org_donation_drive_details.dart';
import 'package:cmsc23_project/screens/org_pages/org_donation_drive_form.dart';
import '../screens/admin_pages/admin_org_details.dart';
import '../screens/admin_pages/admin_profile.dart';
import '../model/donation.dart';
import '../model/organization.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'screens/admin_pages/admin_approval_details.dart';
import 'screens/admin_pages/admin_donation_details.dart';
import 'screens/admin_pages/admin_donation_drive_details.dart';
import 'screens/admin_pages/admin_donor_details.dart';
import 'screens/admin_pages/admin_home.dart';
import 'screens/donor_pages/donor_donation.dart';
import 'screens/donor_pages/donor_home.dart';
import 'package:cmsc23_project/screens/donor_pages/donor_org_details.dart';
import 'screens/donor_pages/donor_profile.dart';
import 'screens/donor_pages/donor_donation_details.dart';
import '../screens/landing.dart';
import '../screens/sign_in.dart';
import '../screens/sign_up.dart';
import 'screens/org_pages/org_donation_details.dart';
import 'screens/org_pages/org_donation_drive.dart';
import 'screens/org_pages/org_profile.dart';
import 'screens/org_pages/org_home.dart';
import 'screens/admin_pages/admin_approvals.dart';
import 'screens/admin_pages/admin_organizations.dart';
import 'screens/admin_pages/admin_donors.dart';
import 'screens/admin_pages/admin_donations.dart';
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
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
        ChangeNotifierProvider(create: ((context) => DonationListProvider())),
        ChangeNotifierProvider(create: ((context) => DonationDriveProvider())),
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
      navigatorKey: GlobalContextService.navigatorKey,
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
        "/admin-home": (context) => AdminHome(),
        "/admin-profile": (context) => AdminProfile(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/organizations": (context) => AdminOrganizationsPage(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/donations": (context) => AdminDonationsPage(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/donors": (context) => AdminDonorsPage(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/approvals": (context) => AdminApprovalsPage(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/organization-info": (context) => AdminOrgDetailsPage(
            orgData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/donationdrive-info": (context) => AdminDonationDriveDetailsPage(
            donationDriveData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/donation-info": (context) => AdminDonationDetailsPage(
            donationData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/admin/donor-info": (context) => AdminDonorDetailsPage(
              donorData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        "/admin/approval-info": (context) => AdminApprovalDetailsPage(
            orgData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        // donor routes
        "/donor-home": (context) => DonorHomePage(),
        "/donor-profile": (context) => DonorProfile(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/donor-org-details": (context) => DonorOrgDetailsPage(
            orgData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/donor-donation": (context) => DonorDonationPage(
            args: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/donor-donations": (context) => DonorDonationList(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/donor-donation-details": (context) => DonorDonationDetails(
            donationData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        // organization routes
        "/org-home": (context) => OrganizationHomePage(),
        "/org-home/donation/details": (context) => OrganizationDonationDetails(
            donationData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/org-home/profile": (context) => OrganizationDetails(userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/org-home/donation-drive": (context) =>
             OrganizationDonationDrivePage(
                userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>
            ),
        "/org-home/donation-drive/details": (context) => OrganizationDonationDriveDetails(
            donationDrive: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
        "/org-home/donation-drive/add": (context) => DonationDriveForm(
            userData: ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>),
      },
    );
  }
}
