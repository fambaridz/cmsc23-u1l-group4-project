import 'package:flutter/material.dart';
import '../../GlobalContextService.dart';
import '../../providers/donation_provider.dart';
import 'package:provider/provider.dart';

class DonorDonationDetails extends StatefulWidget {
  final Map<String, dynamic> donationData;
  const DonorDonationDetails({Key? key, required this.donationData}) : super(key: key);

  @override
  State<DonorDonationDetails> createState() => _DonorDonationDetailsState();
}

class _DonorDonationDetailsState extends State<DonorDonationDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donation Details"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Category', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${widget.donationData['category']}', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pickup or Drop-off', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${widget.donationData['pickupOrDropoff']}', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Item Weight', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${widget.donationData['weight']}', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Address', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text (
                          '${widget.donationData['address']}', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.donationData['pickupOrDropoff'] == 'Pickup')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pick-up Date & Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 55.0),
                              child: Text (
                                '${widget.donationData['pickUpDateTime']}', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (widget.donationData['pickupOrDropoff'] == 'Drop-off')
                      Row(
                        children: [
                          Text('Drop-off Date & Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 40.0),
                              child: Text (
                                '${widget.donationData['dropOffDateTime']}', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Donation Status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${widget.donationData['status']}', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Item Photo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    if (widget.donationData['itemPhotoUrl'] != "No photo uploaded.")
                      Image.network('${widget.donationData['itemPhotoUrl']}', width: 200, height: 200),
                    if (widget.donationData['itemPhotoUrl'] == "No photo uploaded.") 
                      Text('No photo uploaded.', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  String? message = await GlobalContextService.navigatorKey.currentContext!
                    .read<DonationListProvider>()
                    .editDonation(widget.donationData['uid'], 5);
                  

                  if (message == "Successfully edited!") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.lightBlue[400],
                        content: const Text(
                          'Donation is successfully cancelled!',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        duration: const Duration(seconds: 5),
                      ),
                    );

                    Navigator.pushNamed(context, '/donor-home');

                  } else if (message != 'Donation is already completed! Cannot edit status.') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text(
                          'Error cancelling donation. Please try again later.',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text(
                          'Donation is already completed! Cannot edit status.',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                },
                child: Text(
                  'Cancel Donation',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
