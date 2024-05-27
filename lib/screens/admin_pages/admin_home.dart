import 'package:cmsc23_project/screens/admin_pages/admin_drawer.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  final Map<String, dynamic> userData;
  const AdminHome({super.key, required this.userData});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int orgCount = 0, donorCount = 0, donationCount = 0, approvalCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF29B6F6), Colors.white],
                begin: FractionalOffset(3.0, 1.0),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: AdminDrawer(
            userData: widget.userData,
          ),
          appBar: AppBar(
            title: const Text("Admin"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                      child: Column(children: [
                    const SizedBox(height: 45),
                    Text(
                      "Welcome back, Admin!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.lightBlue[400]),
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[400],
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(116, 158, 158, 158),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(1, 3))
                          ],
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Here's an Overview",
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Total Number of Organizations:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$orgCount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Total Number of Donors",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$donorCount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Total Number of Complete Donations",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$donationCount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Accounts Waiting for Approval",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$approvalCount",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ]))
                ],
              ),
            ),
          ),
        ));
  }
}
