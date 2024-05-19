import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../GlobalContextService.dart';
import '../model/donation.dart';
import '../providers/donation_provider.dart';

class DonorDonationPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DonorDonationPage({super.key, required this.userData});

  @override
  State<DonorDonationPage> createState() => _DonorDonationPageState();
}

class _DonorDonationPageState extends State<DonorDonationPage> {
  final _formKey = GlobalKey<FormState>();

  List<String> donationCategories = [
    'Food',
    'Clothes',
    'Cash',
    'Necessities',
    'Others',
  ];

  List<String> shippingOptions = ['Pickup', 'Drop-off'];

  String? _selectedCategory;
  String _pickupOrDropoff = 'Pickup';
  double _itemWeight = 0.0;
  String? _selectedUnit;
  late File _itemPhoto = File('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor Donation"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: heading),
                donationItemCategory,
                pickupOrDropoff,
                itemWeight,
                itemPhoto,
                submitButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get heading => Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Item Donation",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.lightBlue[400],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      );

  Widget get donationItemCategory => Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Donation Category",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: donationCategories.map((category) {
                return CheckboxListTile(
                  title: Text(category,
                      style: TextStyle(
                        fontSize: 15.0,
                      )),
                  value: _selectedCategory == category,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value!) {
                        _selectedCategory = category;
                      } else {
                        _selectedCategory = null;
                      }
                    });
                  },
                  activeColor: Colors.lightBlue[400],
                );
              }).toList(),
            ),
          ],
        ),
      );

  Widget get pickupOrDropoff => Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Pickup or Drop-off",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...shippingOptions.map((option) {
              return Row(
                children: [
                  Radio(
                    value: option,
                    groupValue: _pickupOrDropoff,
                    onChanged: (String? value) {
                      setState(() {
                        _pickupOrDropoff = value!;
                      });
                    },
                    activeColor: Colors.lightBlue[400],
                  ),
                  Text(option),
                ],
              );
            }).toList(),
          ],
        ),
      );

  Widget get itemWeight => Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Weight',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  setState(() {
                    _itemWeight = double.parse(value!);
                  });
                },
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Unit',
                  border: OutlineInputBorder(),
                ),
                value: _selectedUnit,
                items: ['kg', 'lbs']
                    .map((unit) => DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUnit = value!;
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget get itemPhoto => Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Photo of the item/s to donate",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: _itemPhoto.path.isEmpty
                  ? Center(
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _takePhoto,
                      ),
                    )
                  : Image.file(_itemPhoto, fit: BoxFit.cover),
            ),
          ],
        ),
      );

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _itemPhoto = File(pickedFile.path);
      });
    }
  }

  Widget get submitButton => ElevatedButton(
        onPressed: () async {
          Donation newDonation;
          if (_pickupOrDropoff == 'Pickup') {
            // Donation for pickup
            newDonation = Donation(
                id: '1',
                donor: widget.userData["name"],
                category: _selectedCategory,
                weight: '$_itemWeight $_selectedUnit',
                address: 'address',
                contactNo: 'contactNo',
                pickUpDateTime: 'pickUpDateTime',
                // photo: _itemPhoto,
                status: 0);
          } else {
            // Donation for drop-off
            newDonation = Donation(
                id: '1',
                donor: widget.userData["name"],
                category: _selectedCategory,
                weight: '$_itemWeight $_selectedUnit',
                address: 'address',
                contactNo: 'contactNo',
                dropOffDateTime: 'dropOffDateTime',
                // photo: _itemPhoto,
                status: 0);
          }

          GlobalContextService.navigatorKey.currentContext!
              .read<DonationListProvider>()
              .addDonation(newDonation);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.lightBlue[400],
              content: const Text(
                'Donation is now submitted. Please wait for confirmation from organization.',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              duration: const Duration(seconds: 5),
            ),
          );

          _formKey.currentState?.reset();
          setState(() {
            _selectedCategory = null;
            _pickupOrDropoff = 'Pickup';
            _itemPhoto = File('');
          });

          // Not sure if it should return to donor home right after submitting
          // if (mounted) Navigator.pushNamed(context, '/donor-home');
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue[200]),
        child: const Text(
          "Submit",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
}
