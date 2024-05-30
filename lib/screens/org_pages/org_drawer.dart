import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganizationDrawer extends StatefulWidget {
  final Map<String, dynamic> userData;
  const OrganizationDrawer({super.key, required this.userData});

  @override
  State<OrganizationDrawer> createState() => _OrganizationDrawerState();
}

class _OrganizationDrawerState extends State<OrganizationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100, maxHeight: 155),
            child: IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            widget.userData['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/org-home/profile", arguments: widget.userData);
                          },
                          icon: Icon(Icons.people_outline, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[400],
                            elevation: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text("Donations"),
            onTap: () {
              Navigator.pushNamed(context, "/org-home", arguments: widget.userData);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text("Donation Drives"),
            onTap: () {
              Navigator.pushNamed(context, "/org-home/donation-drive", arguments: widget.userData);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              context.read<UserAuthProvider>().signOut();
              Navigator.pushNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }
}
