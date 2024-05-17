import 'package:flutter/material.dart';

class OrganizationDonationDetails extends StatelessWidget {
  final Map info;
  const OrganizationDonationDetails(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    print(info);
    var details = info["details"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Donor: ${details.donor}"),
            Text("Category ${details.category}"),
            Text("Weight: ${details.weight.toString()}"),
            Text("Pickup Address: ${details.address}"),
            Text("Pickup Contact number: ${details.contactNo}"),
            Text("Pickup Date and Time: ${details.pickUpDateTime}"),
            Text("Drop-off Date and Time: ${details.dropOffDateTime}"),
            Text("Photo: ${details.photo}"),
          ],
        ),
      ),
    );
  }
}
