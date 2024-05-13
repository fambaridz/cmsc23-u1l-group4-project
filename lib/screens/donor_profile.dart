import 'package:flutter/material.dart';

class DonorProfile extends StatelessWidget {
  const DonorProfile({Key? key}) : super(key: key);

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
                  "John Doe",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  "@johndoe",
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
        "09123456789",
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
          "123 Main St., City of Manila, Metro Manila",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 20,
            
          ),
        ),
      ),
    ],
  );
}
