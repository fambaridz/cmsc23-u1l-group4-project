import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DonorQRPage extends StatelessWidget {
  final String message;
  const DonorQRPage(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donor QR Code")),
      body: Center(
        child: Column (
          children: [
            Text("Screenshot this QR Code", style: TextStyle(fontSize: 20)),
            QrImageView(
              data: this.message,
              version: QrVersions.auto,
              size: 250.0,
            ),
          ],
        ),
      ),
    );
  } 
}