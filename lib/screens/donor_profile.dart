import 'package:flutter/material.dart';

class DonorProfile extends StatelessWidget {
  final Map<String, dynamic> userData;

  const DonorProfile({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[400],
      appBar: AppBar(
        title: Text("Donor Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  userData['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "@${userData['username']}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            "Personal details",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          Divider(),
                          SizedBox(height: 20),
                          contactDetails,
                          SizedBox(height: 20),
                          address,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get contactDetails => Row (
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Contact number",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        userData['contact_num'],
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    ],
  );

  Widget get address => Row (
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Address",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Flexible(
        flex: 3,
        child: Text(
          userData['address'],
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 20,
            
          ),
        ),
      ),
    ],
  );
}
