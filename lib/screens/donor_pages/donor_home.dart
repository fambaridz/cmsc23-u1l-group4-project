import 'package:cmsc23_project/screens/donor_pages/donor_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  late Map<String, dynamic> userData;
  User? user;
  List<Map<String, dynamic>> organizations = [];

  @override
  void initState() {
    super.initState();
    getVerifiedAndOpenOrganizations();
  }

  void getVerifiedAndOpenOrganizations() async {
    List<Map<String, dynamic>>? orgList = await context.read<UserAuthProvider>().getOrganizations();

    if (orgList != null) {
      List<Map<String, dynamic>>? verifiedOrgs = [];
      for (var org in orgList) {
        if (org['isVerified'] && org['status'] == true) {
          verifiedOrgs.add(org);
        }
      }

      setState(() {
        organizations = verifiedOrgs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    if (user != null) {
      context.read<UserAuthProvider>().getUserData(user!.uid).then((value) {
      setState(() {
        userData = value!;
      });
    });};
    
    return Scaffold(
      drawer: DonorDrawer(userData: userData),
      appBar: AppBar(
        title: Text("Donor Home"),
      ),
      body: Center(
        child: organizations.isEmpty
          ? const Text(
              "No organizations are accepting donations at the moment. Please check back later.",
              textAlign: TextAlign.center,
            )
          : ListView(
              padding: const EdgeInsets.all(10),
              children: organizations
                .map((organization) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/donor-org-details", arguments: organization);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(20),
                      title: Text(
                        organization['name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/donor-donation", arguments: {
    'userData': userData,
    'organization': organization,
  },);
                        },
                        child: Text(
                          "Donate",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
                .toList(),
            ),
      ),
    );
  }
}
