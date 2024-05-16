import 'package:flutter/material.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue[200],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/admin-profile");
                        },
                        child: const Text(
                          "View Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue[400],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.pushNamed(context, "/admin-home");
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_rounded),
            title: Text("Organizations"),
            onTap: () {
              Navigator.pushNamed(context, "/admin/organizations");
            },
          ),
          ListTile(
            leading: Icon(Icons.poll_rounded),
            title: Text("Donations"),
            onTap: () {
              Navigator.pushNamed(context, "/admin/donations");
            },
          ),
          ListTile(
            leading: Icon(Icons.recent_actors_rounded),
            title: Text("Donors"),
            onTap: () {
              Navigator.pushNamed(context, "/admin/donors");
            },
          ),
          ListTile(
            leading: Icon(Icons.playlist_add_check_circle),
            title: Text("For Approval"),
            onTap: () {
              Navigator.pushNamed(context, "/admin/approvals");
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }
}
